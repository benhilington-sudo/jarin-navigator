import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const SettingsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final auth = context.watch<AuthService>();
    final s = settings.strings;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.settings),
        leading: onBack != null
            ? IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded),
              )
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (auth.isLoggedIn) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppTheme.accent.withValues(alpha: 0.18),
                      backgroundImage: user?.photoUrl != null
                          ? NetworkImage(user!.photoUrl!)
                          : null,
                      child: user?.photoUrl == null
                          ? Icon(
                              Icons.person_rounded,
                              size: 30,
                              color: AppTheme.accent,
                            )
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? user?.email ?? 'User',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (user?.email != null)
                            Text(
                              user!.email!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          if (user?.emailVerified == false) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.warning.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Email не подтверждён',
                                style: TextStyle(fontSize: 11, color: AppTheme.warning),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          _SectionTitle(title: s.themeSection),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  title: s.darkTheme,
                  subtitle: s.lightTheme,
                  trailing: Switch(
                    value: settings.themeMode == ThemeMode.light,
                    onChanged: (_) => settings.toggleTheme(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: s.languageSection),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.language_rounded,
                  title: 'Русский',
                  subtitle: '',
                  trailing: settings.language == AppLanguage.ru
                      ? const Icon(Icons.check_circle_rounded,
                          color: AppTheme.accent)
                      : null,
                  onTap: () => settings.setLanguage(AppLanguage.ru),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.translate_rounded,
                  title: 'English',
                  subtitle: '',
                  trailing: settings.language == AppLanguage.en
                      ? const Icon(Icons.check_circle_rounded,
                          color: AppTheme.accent)
                      : null,
                  onTap: () => settings.setLanguage(AppLanguage.en),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: s.about),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.accent, AppTheme.accentLight],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.navigation_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.appName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            s.version,
                            style: TextStyle(color: sub, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    s.aboutText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          if (auth.isLoggedIn) ...[
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () async {
                await auth.signOut();
                if (context.mounted) {
                  Navigator.of(context).popUntil((r) => r.isFirst);
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.danger.withValues(alpha: 0.6)),
                foregroundColor: AppTheme.danger,
              ),
              icon: const Icon(Icons.logout_rounded),
              label: Text(s.logout),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.accent,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle = '',
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.accent, size: 22),
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: Theme.of(context).textTheme.bodyMedium)
          : null,
      trailing: trailing,
    );
  }
}
