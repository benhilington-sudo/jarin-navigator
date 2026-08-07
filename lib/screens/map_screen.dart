import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../data/world_data.dart';
import '../l10n/strings.dart';
import '../models/camera_spot.dart';
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

  const MapScreen({
    super.key,
    required this.onMenuTap,
    required this.onSearchTap,
    required this.onBusTap,
    required this.onSettingsTap,
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
    _mapController.move(engine.position, _zoom < 12 ? 16 : _zoom);
    setState(() => _following = true);
  }

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (hasGesture) {
      _following = false;
    }
    _zoom = camera.zoom;
  }

  void _startNavigationFromQuick(String name, double lat, double lon) {
    final engine = context.read<NavigationEngine>();
    engine.findRoutes(
      destination: LatLng(lat, lon),
      name: name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsService>().strings;
    final engine = context.watch<NavigationEngine>();
    final settings = context.watch<SettingsService>();
    final isDark = settings.themeMode == ThemeMode.dark;
    final isRu = settings.language == AppLanguage.ru;

    if (_following && engine.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _following) {
          _mapController.moveAndRotate(engine.position, 16.5, engine.heading);
        }
      });
    }

    final tileUrl = isDark
        ? 'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png'
        : 'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png';

    final padTop = MediaQuery.of(context).padding.top;
    final padBot = MediaQuery.of(context).padding.bottom;

    return Stack(
      children: [
        // Map
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: engine.position,
            initialZoom: 4,
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
              tileProvider: NetworkTileProvider(),
              tileSize: 256,
              maxZoom: 19,
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
                    radius: 260,
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
                icon: Icons.directions_bus_rounded,
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
                onTap: () {},
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

        // GPS warning
        if (engine.isActive && !engine.gpsAvailable)
          Positioned(
            top: padTop + 60,
            left: 12,
            right: 12,
            child: Card(
              color: AppTheme.warning,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.location_off_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        isRu ? 'Включите геолокацию для навигации' : 'Enable location for navigation',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      return Stack(
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

    if (engine.isActive && engine.activePolyline.isNotEmpty) {
      final pts = engine.activePolyline;
      final count = pts.length;
      if (count < 2) return const SizedBox.shrink();

      return PolylineLayer(
        polylines: [
          // Shadow
          Polyline(
            points: pts,
            strokeWidth: 10,
            color: AppTheme.routeStart.withValues(alpha: 0.15),
          ),
          // Gradient segments
          for (var i = 0; i < count - 1; i++)
            Polyline(
              points: [pts[i], pts[i + 1]],
              strokeWidth: 6,
              color: Color.lerp(
                AppTheme.routeStart,
                AppTheme.routeEnd,
                count > 1 ? i / (count - 1) : 0,
              )!,
            ),
        ],
      );
    }

    return const SizedBox.shrink();
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
  final double size;

  const _SideBtn({
    required this.icon,
    required this.onTap,
    required this.isDark,
    this.bg,
    this.fg,
    this.size = 44,
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
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.05),
                width: 0.5,
              ),
            ),
            child: Icon(icon, color: fgColor, size: size * 0.48),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: BorderRadius.circular(14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: AppTheme.accent),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dist,
                style: TextStyle(
                  fontSize: 18,
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
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.72),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.08),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.success, AppTheme.routeEnd],
                    ),
                    borderRadius: BorderRadius.circular(8),
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
                const SizedBox(width: 8),
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

// ── Camera marker ──
class _CameraMarker extends StatefulWidget {
  final CameraSpot camera;
  final bool highlighted;
  final Strings strings;

  const _CameraMarker({
    required this.camera,
    required this.highlighted,
    required this.strings,
  });

  @override
  State<_CameraMarker> createState() => _CameraMarkerState();
}

class _CameraMarkerState extends State<_CameraMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0,
      upperBound: 1,
    );
    _scale = Tween(begin: 1.0, end: 1.45).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    if (widget.highlighted) _pulse.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant _CameraMarker old) {
    super.didUpdateWidget(old);
    if (old.highlighted != widget.highlighted) {
      if (widget.highlighted) {
        _pulse.repeat(reverse: true);
      } else {
        _pulse.stop();
        _pulse.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Color get _color => switch (widget.camera.type) {
        CameraType.speed => const Color(0xFFFFB300),
        CameraType.trafficLight => const Color(0xFF4CAF50),
        CameraType.lane => const Color(0xFF9C27B0),
        CameraType.redLight => const Color(0xFFF44336),
      };

  @override
  Widget build(BuildContext context) {
    final size = widget.highlighted ? 34.0 : 22.0;
    return Center(
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, _) {
          return Transform.scale(
            scale: widget.highlighted ? _scale.value : 1.0,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _color.withValues(alpha: widget.highlighted ? 0.85 : 0.7),
                border: Border.all(color: Colors.white, width: widget.highlighted ? 3 : 2),
                boxShadow: widget.highlighted
                    ? [BoxShadow(color: _color.withValues(alpha: 0.8), blurRadius: 16, spreadRadius: 4)]
                    : null,
              ),
              child: Center(
                child: Icon(
                  Icons.photo_camera_rounded,
                  size: widget.highlighted ? 16 : 10,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accent, Color(0xFF0055D4)],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            name.isNotEmpty ? name : 'Цель',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(Icons.arrow_drop_down, color: AppTheme.accent, size: 24),
      ],
    );
  }
}
