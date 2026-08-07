import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class ProgressBar extends StatelessWidget {
  final VoidCallback onCancel;

  const ProgressBar({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsService>().strings;
    final engine = context.watch<NavigationEngine>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!engine.isActive) return const SizedBox.shrink();

    final rem = engine.remainingMeters;
    final total = engine.totalMeters;
    final progress = total > 0 ? 1 - (rem / total) : 1.0;
    final eta = engine.estimateEta(rem);
    final hours = eta.inHours;
    final mins = eta.inMinutes.remainder(60);
    final timeStr = hours > 0 ? '$hours:${mins.toString().padLeft(2, '0')}' : '$mins';
    final distStr = rem >= 1000
        ? '${(rem / 1000).toStringAsFixed(1)} ${s.kilometers}'
        : '${rem.round()} ${s.meters}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.darkSurface.withValues(alpha: 0.95)
            : AppTheme.lightSurface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, -2),
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
                Icon(Icons.route_rounded, color: AppTheme.accent, size: 20),
                const SizedBox(width: 8),
                Text(
                  distStr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                  ),
                ),
                const Spacer(),
                Text(
                  timeStr,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                  ),
                ),
                const Spacer(),
                Text(
                  s.arrivalTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
                  ),
                ),
                const Spacer(),
                Text(
                  '${engine.etaMinutes} ${s.minutesShort}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.danger.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close_rounded, color: AppTheme.danger, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 4,
                backgroundColor: (isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext)
                    .withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
