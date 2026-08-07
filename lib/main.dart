import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_init_stub.dart'
    if (dart.library.io) 'firebase_init_native.dart';
import 'services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsService();
  await settings.load();
  final firebaseReady = await initFirebase();
  runApp(JarinApp(settings: settings, firebaseReady: firebaseReady));
}
