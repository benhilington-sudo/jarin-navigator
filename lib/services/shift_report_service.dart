import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripRecord {
  final double distanceMeters;
  final int durationSeconds;
  final DateTime timestamp;

  const TripRecord({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'd': distanceMeters,
        's': durationSeconds,
        't': timestamp.millisecondsSinceEpoch,
      };

  factory TripRecord.fromJson(Map<String, dynamic> j) => TripRecord(
        distanceMeters: (j['d'] as num).toDouble(),
        durationSeconds: j['s'] as int,
        timestamp: DateTime.fromMillisecondsSinceEpoch(j['t'] as int),
      );
}

class ShiftReportService extends ChangeNotifier {
  static const _kTrips = 'jarin.shift.trips';
  static const _kShiftStart = 'jarin.shift.start';
  static const _kIsOnShift = 'jarin.shift.active';

  late SharedPreferences _prefs;

  bool _isOnShift = false;
  DateTime? _shiftStart;
  List<TripRecord> _trips = [];
  Timer? _tickTimer;

  bool get isOnShift => _isOnShift;
  DateTime? get shiftStart => _shiftStart;
  List<TripRecord> get trips => List.unmodifiable(_trips);

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _isOnShift = _prefs.getBool(_kIsOnShift) ?? false;
    final startMs = _prefs.getInt(_kShiftStart);
    if (startMs != null) _shiftStart = DateTime.fromMillisecondsSinceEpoch(startMs);

    final raw = _prefs.getString(_kTrips);
    if (raw != null && raw.isNotEmpty) {
      try {
        final list = json.decode(raw) as List;
        _trips = list.map((e) => TripRecord.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {
        _trips = [];
      }
    }

    if (_isOnShift) _startTick();
    notifyListeners();
  }

  void startShift() {
    _isOnShift = true;
    _shiftStart = DateTime.now();
    _trips = [];
    _prefs.setBool(_kIsOnShift, true);
    _prefs.setInt(_kShiftStart, _shiftStart!.millisecondsSinceEpoch);
    _prefs.setString(_kTrips, '[]');
    _startTick();
    notifyListeners();
  }

  void endShift() {
    _isOnShift = false;
    _tickTimer?.cancel();
    _tickTimer = null;
    _prefs.setBool(_kIsOnShift, false);
    notifyListeners();
  }

  void recordTrip(double distanceMeters, int durationSeconds) {
    _trips.add(TripRecord(
      distanceMeters: distanceMeters,
      durationSeconds: durationSeconds,
      timestamp: DateTime.now(),
    ));
    _saveTrips();
    notifyListeners();
  }

  void clearHistory() {
    _trips = [];
    _shiftStart = null;
    _isOnShift = false;
    _tickTimer?.cancel();
    _tickTimer = null;
    _prefs.remove(_kIsOnShift);
    _prefs.remove(_kShiftStart);
    _prefs.remove(_kTrips);
    notifyListeners();
  }

  void _saveTrips() {
    final data = _trips.map((t) => t.toJson()).toList();
    _prefs.setString(_kTrips, jsonEncode(data));
  }

  void _startTick() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) => notifyListeners());
  }

  int get totalTrips => _trips.length;

  double get totalKm {
    var sum = 0.0;
    for (final t in _trips) sum += t.distanceMeters;
    return sum / 1000;
  }

  Duration get totalTime {
    if (_isOnShift) return shiftDuration;
    var sec = 0;
    for (final t in _trips) sec += t.durationSeconds;
    return Duration(seconds: sec);
  }

  Duration get shiftDuration {
    if (_shiftStart == null) return Duration.zero;
    return DateTime.now().difference(_shiftStart!);
  }

  double get avgSpeedKmh {
    final h = shiftDuration.inSeconds / 3600;
    if (h <= 0) return 0;
    return totalKm / h;
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}
