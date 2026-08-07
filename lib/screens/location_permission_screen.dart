import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class LocationPermissionScreen extends StatefulWidget {
  final VoidCallback onGranted;

  const LocationPermissionScreen({super.key, required this.onGranted});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scale;
  bool _loading = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _scale = Tween(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _request() async {
    setState(() {
      _loading = true;
      _errorMsg = null;
    });

    try {
      if (kIsWeb) {
        // На вебе — просто запрашиваем (браузер покажет свой диалог)
        final perm = await Geolocator.requestPermission();
        if (perm == LocationPermission.whileInUse ||
            perm == LocationPermission.always) {
          widget.onGranted();
        } else {
          setState(() => _errorMsg = 'Доступ отклонён');
        }
      } else {
        // На телефоне — проверяем службы + разрешение
        final serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          setState(() => _errorMsg = 'Геолокация выключена. Включите GPS.');
          return;
        }

        var perm = await Geolocator.checkPermission();
        if (perm == LocationPermission.denied) {
          perm = await Geolocator.requestPermission();
        }

        if (perm == LocationPermission.denied) {
          setState(() => _errorMsg = 'Доступ отклонён');
          return;
        }

        if (perm == LocationPermission.deniedForever) {
          await Geolocator.openAppSettings();
          setState(() => _errorMsg = 'Откройте настройки и разрешите геолокацию');
          return;
        }

        widget.onGranted();
      }
    } catch (e) {
      setState(() => _errorMsg = 'Ошибка: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final isRu = settings.language == AppLanguage.ru;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              AnimatedBuilder(
                animation: _scale,
                builder: (context, _) {
                  return Transform.scale(
                    scale: _scale.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        size: 56,
                        color: AppTheme.accent,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                isRu ? 'Нужна геолокация' : 'Location required',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                kIsWeb
                    ? (isRu
                        ? 'Нажмите кнопку ниже, чтобы браузер запросил доступ к вашему местоположению.'
                        : 'Press the button below to let the browser request access to your location.')
                    : (isRu
                        ? 'Для навигации необходим доступ к вашей геопозиции.'
                        : 'Location access is required for navigation.'),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              if (_loading)
                const CircularProgressIndicator(strokeWidth: 2)
              else ...[
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _request,
                    child: Text(
                      isRu ? 'Разрешить доступ' : 'Allow access',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (_errorMsg != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline,
                            color: AppTheme.warning, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMsg!,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppTheme.darkText
                                  : AppTheme.lightText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _request,
                    child: Text(
                      isRu ? 'Попробовать снова' : 'Try again',
                    ),
                  ),
                ],
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
