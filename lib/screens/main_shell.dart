import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../services/favorites_service.dart';
import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../services/shift_report_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_bar.dart';
import 'bus_stop_screen.dart';
import 'favorites_screen.dart';
import 'map_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'shift_report_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with SingleTickerProviderStateMixin {
  NavTab _tab = NavTab.map;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _goToMap() => setState(() => _tab = NavTab.map);

  void _onTab(NavTab tab) {
    if (tab == _tab) return;
    _fadeController.reset();
    setState(() => _tab = tab);
    _fadeController.forward();
  }

  void _navigateTo(String name, double lat, double lng) {
    final engine = context.read<NavigationEngine>();
    engine.findRoutes(
      destination: LatLng(lat, lng),
      name: name,
    );
    _goToMap();
  }

  void _openMenu() {
    final settings = context.read<SettingsService>();
    final isDark = settings.themeMode == ThemeMode.dark;
    final isRu = settings.language == AppLanguage.ru;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              _MenuItem(
                icon: Icons.person_outline_rounded,
                title: isRu ? 'Профиль' : 'Profile',
                onTap: () {
                  Navigator.pop(ctx);
                  _onTab(NavTab.settings);
                },
                isDark: isDark,
              ),
              _MenuItem(
                icon: Icons.directions_bus_rounded,
                title: isRu ? 'Автобусы' : 'Buses',
                onTap: () {
                  Navigator.pop(ctx);
                  _onTab(NavTab.bus);
                },
                isDark: isDark,
              ),
              _MenuItem(
                icon: Icons.bookmark_border_rounded,
                title: isRu ? 'Избранное' : 'Favorites',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FavoritesScreen(onNavigate: _navigateTo),
                    ),
                  );
                },
                isDark: isDark,
              ),
              _MenuItem(
                icon: Icons.assessment_rounded,
                title: isRu ? 'Отчёт за смену' : 'Shift Report',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ShiftReportScreen(onBack: () => Navigator.pop(context)),
                    ),
                  );
                },
                isDark: isDark,
              ),
              _MenuItem(
                icon: Icons.settings_rounded,
                title: isRu ? 'Настройки' : 'Settings',
                onTap: () {
                  Navigator.pop(ctx);
                  _onTab(NavTab.settings);
                },
                isDark: isDark,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final isDark = settings.themeMode == ThemeMode.dark;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(
          index: _tab.index,
          children: [
            MapScreen(
              onMenuTap: _openMenu,
              onSearchTap: () => _onTab(NavTab.search),
              onBusTap: () => _onTab(NavTab.bus),
              onSettingsTap: () => _onTab(NavTab.settings),
            ),
            SearchScreen(onNavigate: _goToMap, onBack: () => _onTab(NavTab.map)),
            BusStopScreen(onBack: () => _onTab(NavTab.map)),
            SettingsScreen(onBack: () => _onTab(NavTab.map)),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentTab: _tab,
        onTabChanged: _onTab,
        onThemeToggle: settings.toggleTheme,
        isDark: isDark,
        onBookmarkTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FavoritesScreen(onNavigate: _navigateTo),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.accent, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? AppTheme.darkText : AppTheme.lightText,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
