import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  StreamSubscription<Position>? _sub;

  /// Пытается получить реальные координаты, иначе возвращает null
  /// (используется симуляция).
  Future<LatLng?> tryGetLocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) return null;
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        ),
      );
      return LatLng(pos.latitude, pos.longitude);
    } catch (e) {
      debugPrint('LocationService: $e');
      return null;
    }
  }

  void startTracking(void Function(LatLng) onUpdate) {
    _sub?.cancel();
    try {
      _sub = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 5,
        ),
      ).listen(
        (p) => onUpdate(LatLng(p.latitude, p.longitude)),
        onError: (_) {},
      );
    } catch (_) {}
  }

  void stopTracking() {
    _sub?.cancel();
    _sub = null;
  }
}
