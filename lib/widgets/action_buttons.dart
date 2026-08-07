import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ActionButtons extends StatelessWidget {
  final bool isDark;
  final VoidCallback onCompass;
  final VoidCallback onParking;
  final VoidCallback onSound;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onNavigate;
  final bool soundOn;

  const ActionButtons({
    super.key,
    required this.isDark,
    required this.onCompass,
    required this.onParking,
    required this.onSound,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onNavigate,
    this.soundOn = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark
        ? Colors.black.withValues(alpha: 0.7)
        : Colors.white.withValues(alpha: 0.85);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Btn(icon: Icons.explore_rounded, bg: AppTheme.accent, fg: Colors.white, onTap: onCompass),
        const SizedBox(height: 8),
        _Btn(icon: Icons.local_parking_rounded, bg: bg, fg: _fg(isDark), onTap: onParking),
        const SizedBox(height: 8),
        _Btn(
          icon: soundOn ? Icons.volume_up_rounded : Icons.volume_off_rounded,
          bg: bg, fg: _fg(isDark), onTap: onSound,
        ),
        const SizedBox(height: 12),
        _Btn(icon: Icons.add_rounded, bg: bg, fg: _fg(isDark), onTap: onZoomIn),
        const SizedBox(height: 6),
        _Btn(icon: Icons.remove_rounded, bg: bg, fg: _fg(isDark), onTap: onZoomOut),
        const SizedBox(height: 12),
        _Btn(
          icon: Icons.navigation_rounded,
          bg: AppTheme.accent,
          fg: Colors.white,
          onTap: onNavigate,
          size: 48,
        ),
      ],
    );
  }

  Color _fg(bool dark) => dark ? AppTheme.darkText : AppTheme.lightText;
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  final double size;

  const _Btn({
    required this.icon,
    required this.bg,
    required this.fg,
    required this.onTap,
    this.size = 42,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: fg, size: size * 0.5),
      ),
    );
  }
}
