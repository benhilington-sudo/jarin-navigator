import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum NavTab { map, search, nearby, settings }

class CustomBottomBar extends StatelessWidget {
  final NavTab currentTab;
  final ValueChanged<NavTab> onTabChanged;
  final VoidCallback onThemeToggle;
  final bool isDark;
  final VoidCallback? onBookmarkTap;

  const CustomBottomBar({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
    required this.onThemeToggle,
    required this.isDark,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.darkSurface.withValues(alpha: 0.96)
            : AppTheme.lightSurface.withValues(alpha: 0.96),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BarIcon(
                icon: Icons.search_rounded,
                selected: currentTab == NavTab.search,
                onTap: () => onTabChanged(NavTab.search),
                isDark: isDark,
              ),
              _BarIcon(
                icon: Icons.bookmark_border_rounded,
                selected: false,
                onTap: onBookmarkTap ?? () {},
                isDark: isDark,
              ),
              _BarIcon(
                icon: Icons.settings_rounded,
                selected: currentTab == NavTab.settings,
                onTap: () => onTabChanged(NavTab.settings),
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final bool isDark;

  const _BarIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.accent.withValues(alpha: isDark ? 0.22 : 0.14)
              : (isDark ? AppTheme.darkCard : const Color(0xFFF2F2F7)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          icon,
          size: 24,
          color: selected
              ? AppTheme.accent
              : (isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext),
        ),
      ),
    );
  }
}
