import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as ml;
import 'package:provider/provider.dart';

import '../services/location_service.dart';
import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;
  final VoidCallback onBusTap;
  final VoidCallback onSettingsTap;
  final VoidCallback? onNearbyTap;

  const MapScreen({
    super.key,
    required this.onMenuTap,
    required this.onSearchTap,
    required this.onBusTap,
    required this.onSettingsTap,
    this.onNearbyTap,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

String _fmtDist(double meters) {
  if (meters >= 1000) {
    return '${(meters / 1000).toStringAsFixed(1)} км';
  }
  return '${meters.round()} м';
}

String _fmtDur(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  if (m >= 60) {
    final h = m ~/ 60;
    final rm = m % 60;
    return '$h ч ${rm > 0 ? '$rm мин' : ''}';
  }
  if (m > 0) return '$m мин';
  return '$s сек';
}

ml.LatLng _toMl(LatLng ll) => ml.LatLng(ll.latitude, ll.longitude);

// Зона вокруг пользователя (в пикселях при данном zoom):
// px = 120 м * 2^zoom / (156543.03 * cos(lat)) — для Москвы cos ≈ 0.563
const _zoneRadius = [
  'interpolate',
  ['exponential', 2],
  ['zoom'],
  10,
  1.39,
  20,
  1428.0,
];

Map<String, dynamic> _lineString(List<LatLng> pts) => {
      'type': 'LineString',
      'coordinates': [
        for (final p in pts) [p.longitude, p.latitude],
      ],
    };

Map<String, dynamic> _emptyCollection() => {
      'type': 'FeatureCollection',
      'features': <dynamic>[],
    };

Map<String, dynamic> _pointFeature(LatLng p, {Map<String, dynamic>? props}) => {
      'type': 'Feature',
      'properties': props ?? <String, dynamic>{},
      'geometry': {
        'type': 'Point',
        'coordinates': [p.longitude, p.latitude],
      },
    };

class _MapScreenState extends State<MapScreen> {
  ml.MapLibreMapController? _controller;
  double _zoom = 16;
  bool _following = true;
  bool _styleReady = false;
  bool _centerAfterLoad = false;
  DateTime _programmaticUntil = DateTime.fromMillisecondsSinceEpoch(0);

  // Кэши источников (пересоздаём только при смене данных)
  List<RouteOption>? _cacheSelOptions;
  int _cacheSelIndex = -1;
  Map<String, dynamic>? _cacheRoutesFc;
  List<LatLng>? _cacheActivePts;
  Map<String, dynamic>? _cacheActiveFc;
  LatLng? _cacheUserPos;
  double? _cacheUserHeading;
  LatLng? _cacheDest;
  String? _cacheDestName;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _locateOnStart();
  }

  @override
  void didUpdateWidget(covariant MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final settings = context.read<SettingsService>();
    final isDark = settings.themeMode == ThemeMode.dark;
    if (isDark != _darkMode) {
      _darkMode = isDark;
      _styleReady = false;
      _resetSourceCaches();
      _controller?.setStyle(_styleUrl(isDark)).catchError((_) {
        _styleReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _styleUrl(bool isDark) => isDark
      ? 'https://jarin-navigator.duckdns.org/ofm/styles/dark.json'
      : 'https://jarin-navigator.duckdns.org/ofm/styles/liberty.json';

  Future<void> _locateOnStart() async {
    final engine = context.read<NavigationEngine>();
    final location = LocationService();
    final point = await location.tryGetLocation();
    if (!mounted || point == null) return;
    engine.setPosition(point);
    _centerAfterLoad = true;
  }

  void _centerOnUser({bool force = false}) {
    final c = _controller;
    if (c == null || !_styleReady) return;
    final engine = context.read<NavigationEngine>();
    setState(() => _following = true);
    final z = engine.isActive
        ? (_zoom < 14 ? 17.0 : _zoom)
        : (_zoom < 12 ? 16.0 : _zoom);
    _programmaticUntil = DateTime.now().add(const Duration(milliseconds: 700));
    c.animateCamera(
      ml.CameraUpdate.newCameraPosition(
        ml.CameraPosition(
          target: _toMl(engine.position),
          zoom: z,
          tilt: engine.isActive ? 60 : 0,
          bearing: engine.isActive ? engine.heading : 0,
        ),
      ),
      duration: Duration(milliseconds: force ? 0 : 500),
    );
  }

  void _onCameraMove(ml.CameraPosition cameraPosition) {
    _zoom = cameraPosition.zoom;
    if (DateTime.now().isAfter(_programmaticUntil) &&
        !_isNavActive(context) &&
        _following) {
      _following = false;
    }
  }

  bool _isNavActive(BuildContext context) =>
      context.read<NavigationEngine>().isActive;

  // Следование за пользователем: двигаем камеру, только если
  // пользователь ушёл от центра экрана дальше порога (~18% меньшей стороны).
  void _followIfNeeded(NavigationEngine engine) {
    final c = _controller;
    if (c == null || !_styleReady) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      try {
        final bounds = await c.getVisibleRegion();
        if (!mounted) return;
        final pos = engine.position;
        final dLat =
            (bounds.northeast.latitude - bounds.southwest.latitude) * 0.18;
        final dLng =
            (bounds.northeast.longitude - bounds.southwest.longitude) * 0.18;
        final inside = pos.latitude >= bounds.southwest.latitude + dLat &&
            pos.latitude <= bounds.northeast.latitude - dLat &&
            pos.longitude >= bounds.southwest.longitude + dLng &&
            pos.longitude <= bounds.northeast.longitude - dLng;
        if (inside) return;
        final z = engine.isActive
            ? (_zoom < 14 ? 17.0 : _zoom)
            : (_zoom < 12 ? 16.0 : _zoom);
        _programmaticUntil =
            DateTime.now().add(const Duration(milliseconds: 700));
        c.animateCamera(
          ml.CameraUpdate.newCameraPosition(
            ml.CameraPosition(
              target: _toMl(pos),
              zoom: z,
              tilt: engine.isActive ? 60 : 0,
              bearing: engine.isActive ? engine.heading : 0,
            ),
          ),
          duration: const Duration(milliseconds: 600),
        );
      } catch (_) {
        // Игнорируем ошибки камеры (напр. на web во время инициализации)
      }
    });
  }

  Future<void> _setupLayers() async {
    final c = _controller;
    if (c == null) return;
    final engine = context.read<NavigationEngine>();
    _programmaticUntil = DateTime.now().add(const Duration(milliseconds: 700));
    if (engine.isActive || _following) {
      c.animateCamera(
        ml.CameraUpdate.newCameraPosition(
          ml.CameraPosition(
            target: _toMl(engine.position),
            zoom: _zoom < 14 ? 17.0 : _zoom,
            tilt: engine.isActive ? 60 : 0,
            bearing: engine.isActive ? engine.heading : 0,
          ),
        ),
        duration: const Duration(milliseconds: 400),
      );
    }

    final arrowBytes = (await rootBundle.load('assets/images/user_arrow.png'))
        .buffer
        .asUint8List();
    final pinBytes =
        (await rootBundle.load('assets/images/dest_pin.png')).buffer
            .asUint8List();
    await c.addImage('user_arrow', arrowBytes);
    await c.addImage('dest_pin', pinBytes);

    // ── Варианты маршрута (выбор) ──
    await c.addGeoJsonSource('routes', _emptyCollection());
    await c.addLineLayer(
      'routes',
      'route-alt',
      const ml.LineLayerProperties(
        lineWidth: 3,
        lineColor: '#1E88E5',
        lineOpacity: 0.35,
      ),
      filter: ['==', ['get', 'selected'], 0],
    );
    await c.addLineLayer(
      'routes',
      'route-main',
      ml.LineLayerProperties(
        lineWidth: [
          'case',
          ['==', ['get', 'selected'], 1],
          5.0,
          3.0,
        ],
        lineColor: [
          'case',
          ['==', ['get', 'selected'], 1],
          '#00E676',
          '#1E88E5',
        ],
        lineOpacity: [
          'case',
          ['==', ['get', 'selected'], 1],
          1.0,
          0.35,
        ],
      ),
      filter: ['!=', ['get', 'selected'], 1],
    );

    // ── Активный маршрут (навигация) ──
    await c.addGeoJsonSource('active', _emptyCollection());
    await c.addLineLayer(
      'active',
      'route-glow',
      const ml.LineLayerProperties(
        lineWidth: 16,
        lineColor: '#00E676',
        lineOpacity: 0.12,
        lineCap: 'round',
      ),
    );
    await c.addLineLayer(
      'active',
      'route-shadow',
      const ml.LineLayerProperties(
        lineWidth: 10,
        lineColor: '#00C853',
        lineOpacity: 0.2,
        lineCap: 'round',
      ),
    );
    await c.addLineLayer(
      'active',
      'route-main',
      const ml.LineLayerProperties(
        lineWidth: 7,
        lineColor: '#00E676',
        lineCap: 'round',
      ),
    );
    await c.addLineLayer(
      'active',
      'route-center',
      const ml.LineLayerProperties(
        lineWidth: 2,
        lineColor: '#FFFFFF',
        lineOpacity: 0.5,
        lineCap: 'round',
      ),
    );

    // ── 3D здания (только тёмная тема: dark стиль без встроенных зданий) ──
    if (_darkMode) {
      await c.addFillExtrusionLayer(
        'openmaptiles',
        'buildings-3d',
        ml.FillExtrusionLayerProperties(
          fillExtrusionColor: '#3A3F4B',
          fillExtrusionOpacity: 0.75,
          fillExtrusionHeight: ['get', 'render_height'],
          fillExtrusionBase: ['get', 'render_min_height'],
        ),
        sourceLayer: 'building',
        filter: ['>', ['get', 'render_height'], 0],
      );
    }

    // ── Зона точности вокруг пользователя ──
    await c.addGeoJsonSource('zone', _emptyCollection());
    await c.addCircleLayer(
      'zone',
      'user-zone',
      const ml.CircleLayerProperties(
        circleRadius: _zoneRadius,
        circleColor: 'rgba(0,230,118,0.08)',
        circleStrokeColor: 'rgba(0,230,118,0.2)',
        circleStrokeWidth: 1.5,
      ),
    );

    // ── Пользователь (стрелка) ──
    await c.addGeoJsonSource('user', _emptyCollection());
    await c.addSymbolLayer(
      'user',
      'user-arrow',
      const ml.SymbolLayerProperties(
        iconImage: 'user_arrow',
        iconSize: 0.32,
        iconAnchor: 'center',
        iconAllowOverlap: true,
        iconIgnorePlacement: true,
        iconRotationAlignment: 'map',
        iconPitchAlignment: 'map',
      ),
    );
    await c.setLayerProperties(
      'user-arrow',
      ml.SymbolLayerProperties(iconRotate: ['get', 'heading']),
    );

    // ── Назначение ──
    await c.addGeoJsonSource('dest', _emptyCollection());
    await c.addSymbolLayer(
      'dest',
      'dest-pin',
      const ml.SymbolLayerProperties(
        iconImage: 'dest_pin',
        iconSize: 0.45,
        iconAnchor: 'bottom',
        iconAllowOverlap: true,
      ),
    );

    _styleReady = true;
    _syncSources(engine);
  }

  void _resetSourceCaches() {
    _cacheRoutesFc = null;
    _cacheActiveFc = null;
    _cacheActivePts = null;
    _cacheUserPos = null;
    _cacheUserHeading = null;
    _cacheDest = null;
    _cacheDestName = null;
  }

  void _syncSources(NavigationEngine engine) {
    final c = _controller;
    if (c == null || !_styleReady) return;

    // Варианты маршрута
    if (engine.isSelecting && engine.routeOptions.isNotEmpty) {
      if (_cacheRoutesFc == null ||
          _cacheSelOptions != engine.routeOptions ||
          _cacheSelIndex != engine.selectedRouteIndex) {
        _cacheSelOptions = engine.routeOptions;
        _cacheSelIndex = engine.selectedRouteIndex;
        _cacheRoutesFc = {
          'type': 'FeatureCollection',
          'features': [
            for (var i = 0; i < engine.routeOptions.length; i++)
              {
                'type': 'Feature',
                'properties': {
                  'selected': i == engine.selectedRouteIndex ? 1 : 0,
                },
                'geometry': _lineString(engine.routeOptions[i].polyline),
              },
          ],
        };
        c.setGeoJsonSource('routes', _cacheRoutesFc!);
      }
    } else if (_cacheRoutesFc != null) {
      _cacheRoutesFc = null;
      c.setGeoJsonSource('routes', _emptyCollection());
    }

    // Активный маршрут
    if (engine.isActive && engine.activePolyline.length >= 2) {
      final pts = engine.activePolyline;
      if (_cacheActiveFc == null || !identical(pts, _cacheActivePts)) {
        _cacheActivePts = pts;
        _cacheActiveFc = {
          'type': 'FeatureCollection',
          'features': [
            {
              'type': 'Feature',
              'properties': <String, dynamic>{},
              'geometry': _lineString(pts),
            },
          ],
        };
        c.setGeoJsonSource('active', _cacheActiveFc!);
      }
    } else if (_cacheActiveFc != null) {
      _cacheActiveFc = null;
      _cacheActivePts = null;
      c.setGeoJsonSource('active', _emptyCollection());
    }

    // Пользователь
    final pos = engine.position;
    final heading = engine.heading;
    if (_cacheUserPos != pos || _cacheUserHeading != heading) {
      _cacheUserPos = pos;
      _cacheUserHeading = heading;
      c.setGeoJsonSource(
        'user',
        _pointFeature(pos, props: {'heading': heading}),
      );
      c.setGeoJsonSource('zone', _pointFeature(pos));
    }

    // Назначение
    final dest = engine.destination;
    final destName = engine.destinationName ?? '';
    if (dest != null && (_cacheDest != dest || _cacheDestName != destName)) {
      _cacheDest = dest;
      _cacheDestName = destName;
      c.setGeoJsonSource('dest', _pointFeature(dest));
    } else if (dest == null && _cacheDest != null) {
      _cacheDest = null;
      _cacheDestName = null;
      c.setGeoJsonSource('dest', _emptyCollection());
    }
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<NavigationEngine>();
    final settings = context.watch<SettingsService>();
    final isDark = settings.themeMode == ThemeMode.dark;
    final isRu = settings.language == AppLanguage.ru;

    _darkMode = isDark;
    if (_styleReady) {
      _syncSources(engine);
    }
    if (_following || engine.isActive) {
      _followIfNeeded(engine);
    }

    final padTop = MediaQuery.of(context).padding.top;
    final padBot = MediaQuery.of(context).padding.bottom;

    return Stack(
      children: [
        // Map
        ml.MapLibreMap(
          initialCameraPosition: ml.CameraPosition(
            target: _toMl(engine.position),
            zoom: _following ? 16 : 4,
          ),
          styleString: _styleUrl(isDark),
          minMaxZoomPreference: const ml.MinMaxZoomPreference(2, 19),
          tiltGesturesEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          onMapCreated: (controller) {
            _controller = controller;
          },
          onStyleLoadedCallback: () async {
            await _setupLayers();
            if (_centerAfterLoad) {
              _centerAfterLoad = false;
              _centerOnUser(force: true);
            }
          },
          onCameraMove: _onCameraMove,
        ),

        // Top bar — hamburger + bus + title + compass
        Positioned(
          top: padTop + 4,
          left: 12,
          right: 12,
          child: Row(
            children: [
              _TopBtn(
                icon: Icons.menu_rounded,
                onTap: widget.onMenuTap,
                isDark: isDark,
              ),
              const SizedBox(width: 8),
              _TopBtn(
                icon: Icons.local_gas_station_rounded,
                onTap: widget.onBusTap,
                isDark: isDark,
              ),
              const Spacer(),
              Column(
                children: [
                  Icon(Icons.water_rounded,
                      size: 20,
                      color: isDark ? Colors.white70 : Colors.black54),
                  const SizedBox(height: 2),
                  Text(
                    'Jarin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _TopBtn(
                icon: Icons.explore_rounded,
                onTap: () {
                  final c = _controller;
                  if (c == null || !_styleReady) return;
                  _programmaticUntil =
                      DateTime.now().add(const Duration(milliseconds: 700));
                  c.animateCamera(
                    ml.CameraUpdate.newCameraPosition(
                      ml.CameraPosition(
                        target: _toMl(engine.position),
                        zoom: _zoom,
                        tilt: 0,
                        bearing: 0,
                      ),
                    ),
                    duration: const Duration(milliseconds: 500),
                  );
                  setState(() => _following = true);
                },
                isDark: isDark,
              ),
            ],
          ),
        ),

        // Right side buttons — Parking, Zoom+, Zoom-
        Positioned(
          right: 12,
          top: padTop + 70,
          child: Column(
            children: [
              _SideBtn(
                icon: Icons.local_parking_rounded,
                onTap: widget.onNearbyTap ?? () {},
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _SideBtn(
                icon: Icons.add_rounded,
                onTap: () {
                  final c = _controller;
                  if (c == null || !_styleReady) return;
                  _programmaticUntil =
                      DateTime.now().add(const Duration(milliseconds: 700));
                  c.animateCamera(ml.CameraUpdate.zoomIn());
                },
                isDark: isDark,
              ),
              const SizedBox(height: 6),
              _SideBtn(
                icon: Icons.remove_rounded,
                onTap: () {
                  final c = _controller;
                  if (c == null || !_styleReady) return;
                  _programmaticUntil =
                      DateTime.now().add(const Duration(milliseconds: 700));
                  c.animateCamera(ml.CameraUpdate.zoomOut());
                },
                isDark: isDark,
              ),
            ],
          ),
        ),

        // Left side button — Navigate
        Positioned(
          left: 12,
          bottom: padBot + 140,
          child: _SideBtn(
            icon: Icons.navigation_rounded,
            onTap: _centerOnUser,
            isDark: isDark,
            bg: AppTheme.accent,
            fg: Colors.white,
          ),
        ),

        // Turn banner
        if (engine.isActive)
          Positioned(
            top: padTop + 60,
            left: 12,
            child: _TurnBanner(
              engine: engine,
              isDark: isDark,
              isRu: isRu,
            ),
          ),

        // Loading indicator
        if (engine.isLoading)
          Positioned(
            top: padTop + 60,
            left: 0,
            right: 0,
            child: const Center(
              child: _LoadingCard(),
            ),
          ),

        // Route options panel
        if (engine.isSelecting)
          Positioned(
            bottom: padBot + 12,
            left: 16,
            right: 16,
            child: _RoutePanel(
              engine: engine,
              isDark: isDark,
              isRu: isRu,
            ),
          ),

        // Progress bar
        if (engine.isActive)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _ProgressBar(
              engine: engine,
              isDark: isDark,
              isRu: isRu,
            ),
          ),
      ],
    );
  }
}

// ── Glass container ──
class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final bool isDark;

  const _GlassContainer({
    required this.child,
    this.padding,
    this.borderRadius,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.72),
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ── Top bar button ──
class _TopBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _TopBtn({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.05),
                width: 0.5,
              ),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white : Colors.black87,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Side button (right/left panels) ──
class _SideBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final Color? bg;
  final Color? fg;

  const _SideBtn({
    required this.icon,
    required this.onTap,
    required this.isDark,
    this.bg,
    this.fg,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = bg ??
        (isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.07));
    final fgColor = fg ?? (isDark ? Colors.white : Colors.black87);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.06),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: fgColor, size: 21),
          ),
        ),
      ),
    );
  }
}

// ── Turn banner ──
class _TurnBanner extends StatelessWidget {
  final NavigationEngine engine;
  final bool isDark;
  final bool isRu;

  const _TurnBanner({
    required this.engine,
    required this.isDark,
    required this.isRu,
  });

  @override
  Widget build(BuildContext context) {
    final step = engine.currentStep;
    if (step == null) return const SizedBox.shrink();

    final dist = _fmtDist(step.distanceMeters);
    final turnIcons = {
      'left': Icons.turn_left_rounded,
      'right': Icons.turn_right_rounded,
      'slight_left': Icons.turn_slight_left_rounded,
      'slight_right': Icons.turn_slight_right_rounded,
      'straight': Icons.straight_rounded,
      'uturn': Icons.u_turn_left_rounded,
    };
    final icon = turnIcons[engine.nextTurn] ?? Icons.straight_rounded;

    return _GlassContainer(
      isDark: isDark,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E676), Color(0xFF00BCD4)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E676).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dist,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                ),
              ),
              if (step.streetName.isNotEmpty)
                Text(
                  step.streetName,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Loading card ──
class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return _GlassContainer(
      isDark: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text(
            'Построение маршрута…',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// ── Route panel ──
class _RoutePanel extends StatefulWidget {
  final NavigationEngine engine;
  final bool isDark;
  final bool isRu;

  const _RoutePanel({
    required this.engine,
    required this.isDark,
    required this.isRu,
  });

  @override
  State<_RoutePanel> createState() => _RoutePanelState();
}

class _RoutePanelState extends State<_RoutePanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic),
    );
    _fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOut),
    );
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final engine = widget.engine;
    final isDark = widget.isDark;
    final isRu = widget.isRu;
    final best = engine.routeOptions.isNotEmpty
        ? engine.routeOptions[engine.selectedRouteIndex]
        : null;

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: _GlassContainer(
          isDark: isDark,
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.success, AppTheme.routeEnd],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      best != null ? _fmtDur(best.etaMinutes * 60) : '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          engine.destinationName ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color:
                                isDark ? AppTheme.darkText : AppTheme.lightText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          best != null ? _fmtDist(best.distanceMeters) : '',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppTheme.darkSubtext
                                : AppTheme.lightSubtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: engine.cancelRoute,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            isRu ? 'Отмена' : 'Cancel',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppTheme.darkText
                                  : AppTheme.lightText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: engine.startSelectedRoute,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.accent, Color(0xFF0055D4)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accent.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            isRu ? 'Ехать' : 'Go',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Progress bar ──
class _ProgressBar extends StatelessWidget {
  final NavigationEngine engine;
  final bool isDark;
  final bool isRu;

  const _ProgressBar({
    required this.engine,
    required this.isDark,
    required this.isRu,
  });

  @override
  Widget build(BuildContext context) {
    final step = engine.currentStep;
    final nextStreet = step?.streetName ?? '';
    final totalRemaining = _fmtDist(engine.remainingMeters);
    final etaTime = _fmtDur(engine.etaMinutes * 60);

    return ClipRRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.white.withValues(alpha: 0.78),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.06),
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00E676), Color(0xFF00BCD4)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E676)
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        etaTime,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$totalRemaining ${isRu ? "осталось" : "left"}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                    const Spacer(),
                    // Cancel
                    GestureDetector(
                      onTap: engine.cancelRoute,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppTheme.danger.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.close_rounded,
                            size: 20, color: AppTheme.danger),
                      ),
                    ),
                  ],
                ),
                if (nextStreet.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        step?.turn == TurnType.turnRight
                            ? Icons.turn_right
                            : step?.turn == TurnType.turnLeft
                                ? Icons.turn_left
                                : Icons.straight,
                        size: 18,
                        color: AppTheme.accent,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          nextStreet,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppTheme.darkSubtext
                                : AppTheme.lightSubtext,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
