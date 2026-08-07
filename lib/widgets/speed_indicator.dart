import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class SpeedIndicator extends StatefulWidget {
  const SpeedIndicator({super.key});

  @override
  State<SpeedIndicator> createState() => _SpeedIndicatorState();
}

class _SpeedIndicatorState extends State<SpeedIndicator> {
  Timer? _blinkTimer;
  bool _warn = false;

  @override
  void initState() {
    super.initState();
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      final engine = context.read<NavigationEngine>();
      if (engine.speedKmh > 80) {
        setState(() => _warn = !_warn);
      } else if (_warn) {
        setState(() => _warn = false);
      }
    });
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = Provider.of<SettingsService>(context).strings;
    final engine = context.watch<NavigationEngine>();
    final speed = engine.speedKmh.round();

    final over = speed > 80;
    final color = over
        ? (_warn ? AppTheme.danger : Colors.white)
        : Colors.white;
    final bg = over
        ? (_warn ? AppTheme.danger : AppTheme.darkSurface.withValues(alpha: 0.9))
        : Colors.black.withValues(alpha: 0.55);

    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(top: 12, right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: color.withValues(alpha: 0.6),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$speed',
              style: TextStyle(
                color: color,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            Text(
              s.kmh,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
