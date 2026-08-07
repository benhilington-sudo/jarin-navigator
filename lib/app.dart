import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'screens/location_permission_screen.dart';
import 'screens/main_shell.dart';
import 'screens/welcome_screen.dart';
import 'services/auth_service.dart';
import 'services/favorites_service.dart';
import 'services/navigation_engine.dart';
import 'services/settings_service.dart';
import 'services/shift_report_service.dart';
import 'services/tts_service.dart';
import 'theme/app_theme.dart';

class JarinApp extends StatefulWidget {
  final SettingsService settings;
  final bool firebaseReady;

  const JarinApp({super.key, required this.settings, this.firebaseReady = false});

  @override
  State<JarinApp> createState() => _JarinAppState();
}

class _JarinAppState extends State<JarinApp> {
  bool _locationGranted = false;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    try {
      if (kIsWeb) {
        try {
          final pos = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: Duration(seconds: 8),
            ),
          );
          if (mounted) {
            context.read<NavigationEngine>().setGpsPosition(
                  LatLng(pos.latitude, pos.longitude),
                );
            setState(() {
              _locationGranted = true;
              _checking = false;
            });
          }
        } catch (_) {
          setState(() {
            _locationGranted = true;
            _checking = false;
          });
        }
        return;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _checking = false;
          _locationGranted = false;
        });
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        try {
          final pos = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: Duration(seconds: 10),
            ),
          );
          if (mounted) {
            context.read<NavigationEngine>().setGpsPosition(
                  LatLng(pos.latitude, pos.longitude),
                );
          }
        } catch (_) {}

        setState(() {
          _locationGranted = true;
          _checking = false;
        });
      } else {
        setState(() {
          _locationGranted = true;
          _checking = false;
        });
      }
    } catch (e) {
      setState(() {
        _locationGranted = true;
        _checking = false;
      });
    }
  }

  void _onLocationGranted() {
    setState(() => _locationGranted = true);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.settings;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: s),
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider.value(value: TtsService(s)),
        ChangeNotifierProvider(
          create: (_) => NavigationEngine(s, TtsService(s)),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => FavoritesService()),
        ChangeNotifierProvider(create: (_) => ShiftReportService()..load()),
      ],
      child: Builder(
        builder: (context) {
          final engine = context.read<NavigationEngine>();
          final shift = context.read<ShiftReportService>();
          engine.onTripFinished = (dist, dur) {
            if (shift.isOnShift) {
              shift.recordTrip(dist, dur);
            }
          };
          return Consumer<AuthService>(
            builder: (context, auth, _) {
              return MaterialApp(
                title: 'Jarin',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light(),
                darkTheme: AppTheme.dark(),
                themeMode: s.themeMode,
                home: _buildHome(s, auth),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHome(SettingsService settings, AuthService auth) {
    if (_checking) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_locationGranted) {
      return LocationPermissionScreen(onGranted: _onLocationGranted);
    }

    if (!auth.isLoggedIn) {
      if (!widget.firebaseReady) {
        return const MainShell();
      }
      return const WelcomeScreen();
    }

    return const MainShell();
  }
}
