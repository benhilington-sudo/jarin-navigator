import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class RouteOptionsPanel extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onCancel;

  const RouteOptionsPanel({
    super.key,
    required this.onStart,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsService>().strings;
    final engine = context.watch<NavigationEngine>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!engine.isSelecting) return const SizedBox.shrink();

    final routes = engine.routeOptions;
    final selected = engine.selectedRouteIndex;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.route_rounded, color: AppTheme.accent, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        engine.destinationName ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: onCancel,
                      icon: const Icon(Icons.close_rounded, size: 22),
                      color: AppTheme.danger,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: routes.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final r = routes[i];
                      final isSelected = i == selected;
                      return GestureDetector(
                        onTap: () => engine.selectRoute(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 130,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.accent.withValues(alpha: 0.18)
                                : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.accent
                                  : (isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext)
                                      .withValues(alpha: 0.3),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    r.icon,
                                    size: 16,
                                    color: isSelected
                                        ? AppTheme.accent
                                        : (isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      r.name,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? AppTheme.accent
                                            : (isDark ? AppTheme.darkText : AppTheme.lightText),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${r.etaMinutes} ${s.minutesShort}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected
                                      ? AppTheme.accent
                                      : (isDark ? AppTheme.darkText : AppTheme.lightText),
                                ),
                              ),
                              Text(
                                '${r.distanceKm} ${s.kilometers}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    s.navigate,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
