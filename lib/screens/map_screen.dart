import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../services/location_service.dart';
import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';
import '../widgets/yellow_arrow_marker.dart';

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

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  double _zoom = 4;
  bool _following = true;

  // Кэши слоёв маршрута (пересоздаём только при смене маршрута, не каждый тик)
  List<RouteOption>? _cacheSelOptions;
  int _cacheSelIndex = -1;
  Widget? _cacheSelectingLayer;
  List<LatLng>? _cacheActivePts;
  Widget? _cacheActiveLayer;

  @override
  void initState() {
    super.initState();
    _locateOnStart();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _locateOnStart() async {
    final engine = context.read<NavigationEngine>();
    final location = LocationService();
    final point = await location.tryGetLocation();
    if (!mounted || point == null) return;
    engine.setPosition(point);
    _mapController.move(point, 16);
  }

  void _centerOnUser() {
    final engine = context.read<NavigationEngine>();
    setState(() => _following = true);
    final z = engine.isActive ? (_zoom < 14 ? 17.0 : _zoom) : (_zoom < 12 ? 16.0 : _zoom);
    _mapController.moveAndRotate(engine.position, z, engine.heading);
  }

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (hasGesture && !_isNavActive(context)) {
      _following = false;
    }
    _zoom = camera.zoom;
  }

  bool _isNavActive(BuildContext context) =>
      context.read<NavigationEngine>().isActive;

  // Следование за пользователем: двигаем камеру, только если
  // пользователь ушёл от центра экрана дальше порога (~18% меньшей стороны).
  void _followIfNeeded(NavigationEngine engine) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cam = _mapController.camera;
      if (cam == null) return;
      final userPixel = cam.latLngToScreenOffset(engine.position);
      final centerPixel = Offset(cam.size.width / 2, cam.size.height / 2);
      final dist = (userPixel - centerPixel).distance;
      final threshold = cam.size.shortestSide * 0.18;
      if (dist > threshold) {
        final z = engine.isActive
            ? (_zoom < 14 ? 17.0 : _zoom)
            : (_zoom < 12 ? 16.0 : _zoom);
        _mapController.moveAndRotate(engine.position, z, engine.heading);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<NavigationEngine>();
    final settings = context.watch<SettingsService>();
    final isDark = settings.themeMode == ThemeMode.dark;
    final isRu = settings.language == AppLanguage.ru;

    if (_following || engine.isActive) {
      _followIfNeeded(engine);
    }

    final tileUrl = isDark
        ? 'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'
        : 'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png';

    final padTop = MediaQuery.of(context).padding.top;
    final padBot = MediaQuery.of(context).padding.bottom;

    return Stack(
      children: [
        // Map
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: engine.position,
            initialZoom: _following ? 16 : 4,
            minZoom: 2,
            maxZoom: 19,
            onPositionChanged: _onPositionChanged,
            backgroundColor: isDark ? AppTheme.darkBg : const Color(0xFFE8EDF3),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: tileUrl,
              userAgentPackageName: 'com.jarin.jarinnavigator',
              maxZoom: 19,
              subdomains: const ['a', 'b', 'c'],
            ),
            _buildRouteLayer(engine),
            MarkerLayer(
              markers: [
                Marker(
                  point: engine.position,
                  width: 50,
                  height: 50,
                  child: YellowArrowMarker(
                    heading: engine.heading,
                    size: 50,
                  ),
                ),
                if (engine.destination != null)
                  Marker(
                    point: engine.destination!,
                    width: 48,
                    height: 48,
                    child: _DestinationMarker(
                      name: engine.destinationName ?? '',
                    ),
                  ),
              ],
            ),
            if (_zoom >= 10)
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: engine.position,
                    radius: 120,
                    useRadiusInMeter: true,
                    color: AppTheme.accent.withValues(alpha: 0.08),
                    borderColor: AppTheme.accent.withValues(alpha: 0.2),
                    borderStrokeWidth: 1,
                  ),
                ],
              ),
          ],
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
                  Icon(Icons.water_rounded, size: 20, color: isDark ? Colors.white70 : Colors.black54),
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
                  _mapController.moveAndRotate(engine.position, _zoom, 0);
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
                  final newZoom = (_zoom + 1).clamp(2.0, 19.0);
                  _mapController.move(engine.position, newZoom);
                },
                isDark: isDark,
              ),
              const SizedBox(height: 6),
              _SideBtn(
                icon: Icons.remove_rounded,
                onTap: () {
                  final newZoom = (_zoom - 1).clamp(2.0, 19.0);
                  _mapController.move(engine.position, newZoom);
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

  Widget _buildRouteLayer(NavigationEngine engine) {
    if (engine.isSelecting && engine.routeOptions.isNotEmpty) {
      if (_cacheSelectingLayer == null ||
          _cacheSelOptions != engine.routeOptions ||
          _cacheSelIndex != engine.selectedRouteIndex) {
        _cacheSelOptions = engine.routeOptions;
        _cacheSelIndex = engine.selectedRouteIndex;
        _cacheSelectingLayer = Stack(
          children: [
            for (var i = 0; i < engine.routeOptions.length; i++)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: engine.routeOptions[i].polyline,
                    strokeWidth: i == engine.selectedRouteIndex ? 5 : 3,
                    color: i == engine.selectedRouteIndex
                        ? AppTheme.accent
                        : AppTheme.accent.withValues(alpha: 0.3),
                  ),
                ],
              ),
          ],
        );
      }
      return _cacheSelectingLayer!;
    }

    if (engine.isActive && engine.activePolyline.isNotEmpty) {
      final pts = engine.activePolyline;
      if (_cacheActiveLayer == null || !identical(pts, _cacheActivePts)) {
        _cacheActivePts = pts;
        _cacheActiveLayer = _buildActivePolyline(pts);
      }
      return _cacheActiveLayer!;
    }

    // Сброс кэшей при смене режима
    if (_cacheSelectingLayer != null || _cacheActiveLayer != null) {
      _cacheSelectingLayer = null;
      _cacheActiveLayer = null;
      _cacheSelOptions = null;
      _cacheActivePts = null;
    }

    return const SizedBox.shrink();
  }

  Widget _buildActivePolyline(List<LatLng> pts) {
    final count = pts.length;
    if (count < 2) return const SizedBox.shrink();

    return PolylineLayer(
      polylines: [
        // Outer glow
        Polyline(
          points: pts,
          strokeWidth: 16,
          color: const Color(0xFF00E676).withValues(alpha: 0.12),
        ),
        // Shadow
        Polyline(
          points: pts,
          strokeWidth: 10,
          color: const Color(0xFF00C853).withValues(alpha: 0.2),
        ),
        // Main gradient
        for (var i = 0; i < count - 1; i++)
          Polyline(
            points: [pts[i], pts[i + 1]],
            strokeWidth: 7,
            color: Color.lerp(
              const Color(0xFF00E676),
              const Color(0xFF00BCD4),
              count > 1 ? i / (count - 1) : 0,
            )!,
          ),
        // White center highlight
        for (var i = 0; i < count - 1; i++)
          Polyline(
            points: [pts[i], pts[i + 1]],
            strokeWidth: 2,
            color: Colors.white.withValues(alpha: 0.5),
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
                    color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                            color: isDark ? AppTheme.darkText : AppTheme.lightText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          best != null ? _fmtDist(best.distanceMeters) : '',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
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
                              color: isDark ? AppTheme.darkText : AppTheme.lightText,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00E676), Color(0xFF00BCD4)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E676).withValues(alpha: 0.3),
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
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
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
                    child: const Icon(Icons.close_rounded, size: 20, color: AppTheme.danger),
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
                        color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
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

// ── Destination marker ──
class _DestinationMarker extends StatelessWidget {
  final String name;

  const _DestinationMarker({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF5252), Color(0xFFD32F2F)],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF5252).withValues(alpha: 0.5),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            name.isNotEmpty ? name : 'Цель',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomPaint(
          size: const Size(20, 12),
          painter: _PinPainter(),
        ),
      ],
    );
  }
}

class _PinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = ui.Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
