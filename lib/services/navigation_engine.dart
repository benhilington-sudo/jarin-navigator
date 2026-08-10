import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'routing_service.dart';
export 'routing_service.dart' show TrafficSegment, TurnType;
import 'settings_service.dart';
import 'tts_service.dart';

enum NavState { idle, loading, selecting, navigating, arrived }

class RouteOption {
  final String name;
  final IconData icon;
  final List<LatLng> polyline;
  final List<RouteStepResult> osrmSteps;
  final double distanceMeters;
  final int etaMinutes;
  final List<TrafficSegment> trafficSegments;

  const RouteOption({
    required this.name,
    required this.icon,
    required this.polyline,
    required this.osrmSteps,
    required this.distanceMeters,
    required this.etaMinutes,
    this.trafficSegments = const [],
  });

  double get distanceKm =>
      double.parse((distanceMeters / 1000).toStringAsFixed(1));
}

class SavedRoute {
  final String name;
  final String address;
  final double lat;
  final double lon;
  final DateTime timestamp;

  const SavedRoute({
    required this.name,
    required this.address,
    required this.lat,
    required this.lon,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'address': address,
        'lat': lat,
        'lon': lon,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };

  factory SavedRoute.fromMap(Map<String, dynamic> m) => SavedRoute(
        name: m['name'] as String,
        address: m['address'] as String,
        lat: (m['lat'] as num).toDouble(),
        lon: (m['lon'] as num).toDouble(),
        timestamp: DateTime.fromMillisecondsSinceEpoch(m['timestamp'] as int),
      );
}

/// Промежуточный шаг для навигации (преобразованный из OSRM).
class NavStep {
  final TurnType turn;
  final LatLng from;
  final LatLng to;
  final double distanceMeters;
  final String streetName;

  const NavStep({
    required this.turn,
    required this.from,
    required this.to,
    required this.distanceMeters,
    this.streetName = '',
  });
}

class NavigationEngine extends ChangeNotifier {
  final SettingsService settings;
  final TtsService tts;
  final RoutingService _routing = RoutingService();
  Function(double distanceMeters, int durationSeconds)? onTripFinished;

  NavigationEngine(this.settings, this.tts);

  Timer? _timer;
  LatLng _position = const LatLng(55.7519, 37.6178);
  bool _gpsAvailable = false;
  LatLng _gpsPosition = const LatLng(55.7519, 37.6178);
  double _heading = 0;
  double _speedKmh = 0;
  double _targetSpeed = 0;
  DateTime? _lastLiveGpsAt;

  NavState _state = NavState.idle;
  List<RouteOption> _routeOptions = [];
  int _selectedRouteIndex = 0;

  List<NavStep> _steps = [];
  List<LatLng> _activePolyline = [];
  int _stepIndex = 0;
  double _distanceInStep = 0;
  String? _destinationName;
  LatLng? _destination;
  final Set<String> _announced = {};

  LatLng get position => _position;
  double get heading => _heading;
  double get speedKmh => _speedKmh;
  NavState get state => _state;
  bool get isActive => _state == NavState.navigating;
  bool get isSelecting => _state == NavState.selecting;
  bool get isLoading => _state == NavState.loading;
  bool get isIdle => _state == NavState.idle;
  bool get isArrived => _state == NavState.arrived;
  bool get gpsAvailable => _gpsAvailable;
  String? get destinationName => _destinationName;
  LatLng? get destination => _destination;
  List<RouteOption> get routeOptions => _routeOptions;
  int get selectedRouteIndex => _selectedRouteIndex;
  List<LatLng> get activePolyline => _activePolyline;

  double get totalMeters {
    var total = 0.0;
    for (final step in _steps) {
      total += step.distanceMeters;
    }
    return total;
  }

  double get remainingMeters {
    if (_steps.isEmpty) return 0;
    var rem = _distanceInStep;
    for (var i = _stepIndex + 1; i < _steps.length; i++) {
      rem += _steps[i].distanceMeters;
    }
    return rem;
  }

  NavStep? get currentStep =>
      _stepIndex < _steps.length ? _steps[_stepIndex] : null;

  List<NavStep> get steps => _steps;

  int get stepCount => _steps.length;
  int get currentStepIndex => _stepIndex;

  int get etaMinutes {
    final eta = estimateEta(remainingMeters);
    return max(1, (eta.inSeconds / 60).ceil());
  }

  Duration estimateEta(double distanceMeters) {
    final now = DateTime.now();
    final hour = now.hour;
    final isWeekend = now.weekday == DateTime.saturday ||
        now.weekday == DateTime.sunday;
    var avgSpeed = isWeekend ? 55.0 : 48.0;
    if ((hour >= 8 && hour <= 10) || (hour >= 17 && hour <= 20)) {
      avgSpeed *= 0.65;
    }
    return Duration(seconds: (distanceMeters / (avgSpeed / 3.6)).round());
  }

  String get instructionText {
    final s = settings.strings;
    final step = currentStep;
    if (step == null) return s.goStraight;
    switch (step.turn) {
      case TurnType.turnRight:
        return s.turnRight;
      case TurnType.turnLeft:
        return s.turnLeft;
      case TurnType.arrive:
        return s.arrival;
      case TurnType.straight:
      case TurnType.depart:
      case TurnType.merge:
      case TurnType.roundabout:
      case TurnType.keep:
        return s.goStraight;
    }
  }

  TurnType get nextTurn => currentStep?.turn ?? TurnType.arrive;

  void setGpsPosition(LatLng point) {
    _gpsPosition = point;
    _gpsAvailable = true;
    _position = point;
    _lastLiveGpsAt = DateTime.now();

    // Если навигация активна, но таймер не запущен — запускаем
    if (_state == NavState.navigating && _timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
    notifyListeners();
  }

  void setFallbackPosition(LatLng point) {
    _gpsPosition = point;
    _gpsAvailable = false;
    _position = point;
    notifyListeners();
  }

  void setPosition(LatLng point) {
    _position = point;
    notifyListeners();
  }

  /// Поиск маршрутов через OSRM (реальные дороги).
  Future<void> findRoutes({
    required LatLng destination,
    required String name,
  }) async {
    _destinationName = name;
    _destination = destination;
    _state = NavState.loading;
    notifyListeners();

    final routes = await _routing.getRoutes(
      origin: _position,
      destination: destination,
    );

    if (routes.isEmpty) {
      _state = NavState.idle;
      notifyListeners();
      return;
    }

    final isRu = settings.language == AppLanguage.ru;
    final names = [
      isRu ? 'Оптимальный' : 'Optimal',
      if (routes.length > 1) (isRu ? 'Альтернативный' : 'Alternative'),
      if (routes.length > 2) (isRu ? 'Быстрый' : 'Fastest'),
    ];
    final icons = [Icons.route_rounded, Icons.alt_route_rounded, Icons.speed_rounded];

    _routeOptions = [
      for (var i = 0; i < routes.length; i++)
        RouteOption(
          name: names[i],
          icon: icons[i],
          polyline: routes[i].polyline,
          osrmSteps: routes[i].steps,
          distanceMeters: routes[i].distanceMeters,
          etaMinutes: routes[i].etaMinutes,
          trafficSegments: routes[i].trafficSegments,
        ),
    ];
    _selectedRouteIndex = 0;
    _state = NavState.selecting;
    _announced.clear();
    notifyListeners();
  }

  void selectRoute(int index) {
    if (index >= 0 && index < _routeOptions.length) {
      _selectedRouteIndex = index;
      notifyListeners();
    }
  }

  void startSelectedRoute() {
    if (_routeOptions.isEmpty) return;
    final selected = _routeOptions[_selectedRouteIndex];
    _activePolyline = selected.polyline;

    // Преобразуем OSRM шаги в NavStep
    _steps = _convertSteps(selected.osrmSteps);
    _stepIndex = 0;
    _distanceInStep = 0;
    _targetSpeed = 0;
    _speedKmh = 0;
    _state = NavState.navigating;

    if (_steps.isNotEmpty) {
      _position = _steps.first.from;
    }

    tts.speak(settings.strings.goodRoad);

    // Таймер запускается ТОЛЬКО при реальном GPS
    if (_gpsAvailable) {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
    notifyListeners();
  }

  List<NavStep> _convertSteps(List<RouteStepResult> osrmSteps) {
    final steps = <NavStep>[];
    for (var i = 0; i < osrmSteps.length; i++) {
      final s = osrmSteps[i];
      final from = s.location;
      final to = (i + 1 < osrmSteps.length)
          ? osrmSteps[i + 1].location
          : from;

      steps.add(NavStep(
        turn: s.turn,
        from: from,
        to: to,
        distanceMeters: s.distanceMeters,
        streetName: s.streetName,
      ));
    }
    return steps;
  }

  void startRoute({
    required LatLng destination,
    required String name,
  }) async {
    await findRoutes(destination: destination, name: name);
    if (_state == NavState.selecting) {
      startSelectedRoute();
    }
  }

  void cancelRoute() {
    _timer?.cancel();
    _timer = null;
    _state = NavState.idle;
    _steps = [];
    _activePolyline = [];
    _routeOptions = [];
    _destinationName = null;
    _destination = null;
    _targetSpeed = 0;
    _speedKmh = 0;
    if (_gpsAvailable) {
      _position = _gpsPosition;
    }
    tts.stop();
    notifyListeners();
  }

  void _tick() {
    if (_state != NavState.navigating || _steps.isEmpty) return;

    // Живой GPS: определяем текущий шаг по реальной позиции
    final live = _lastLiveGpsAt != null &&
        DateTime.now().difference(_lastLiveGpsAt!) < const Duration(seconds: 4);

    if (live) {
      final dist = const Distance();
      while (_stepIndex < _steps.length) {
        final st = _steps[_stepIndex];
        final d = dist.as(LengthUnit.Meter, _position, st.to);
        if (d < 20) {
          _stepIndex++;
          _distanceInStep = 0;
        } else {
          break;
        }
      }
      final step = currentStep;
      if (step == null) {
        _finish();
        return;
      }
      final rem = dist.as(LengthUnit.Meter, _position, step.to);
      _distanceInStep = max(0.0, step.distanceMeters - rem);
      _announceStep(step, rem);
      _heading = _bearing(_position, step.to);
      notifyListeners();
      return;
    }

    // Симуляция (нет свежих GPS-данных)
    final target = _targetSpeed;
    _speedKmh += (target - _speedKmh) * 0.25;
    if (_speedKmh < 0) _speedKmh = 0;

    final step = currentStep;
    if (step == null) {
      _finish();
      return;
    }

    final metersPerSec = _speedKmh / 3.6;
    _distanceInStep += metersPerSec;

    final stepRemaining = step.distanceMeters - _distanceInStep;
    _announceStep(step, stepRemaining);

    if (_distanceInStep >= step.distanceMeters) {
      _distanceInStep -= step.distanceMeters;
      _stepIndex++;
      if (_stepIndex >= _steps.length) {
        _finish();
        return;
      }
    }

    final seg = _steps[_stepIndex];
    final t = (_distanceInStep / seg.distanceMeters).clamp(0.0, 1.0);
    _position = LatLng(
      seg.from.latitude + (seg.to.latitude - seg.from.latitude) * t,
      seg.from.longitude + (seg.to.longitude - seg.from.longitude) * t,
    );
    _heading = _bearing(seg.from, seg.to);
    _targetSpeed = 40 + (_heading % 20);
    notifyListeners();
  }

  void _announceStep(NavStep step, double stepRemaining) {
    final s = settings.strings;
    if (step.turn != TurnType.straight &&
        step.turn != TurnType.arrive &&
        step.turn != TurnType.depart &&
        step.turn != TurnType.merge) {
      final key = '$_stepIndex';
      if (!_announced.contains(key) && stepRemaining <= 300) {
        _announced.add(key);
        final street = step.streetName.isNotEmpty ? step.streetName : '';
        final dir = step.turn == TurnType.turnRight ? s.turnRight : s.turnLeft;
        final msg = street.isNotEmpty ? '$dir, $street' : dir;
        tts.speak(msg);
      }
    }
  }

  void _finish() {
    _state = NavState.arrived;
    _speedKmh = 0;
    _targetSpeed = 0;
    _timer?.cancel();

    // Record trip for shift report
    if (totalMeters > 0) {
      final elapsed = _steps.isNotEmpty ? (totalMeters / (40 / 3.6)).round() : 0;
      onTripFinished?.call(totalMeters, elapsed);
    }

    tts.speak(settings.strings.arrival);
    notifyListeners();
  }

  double _bearing(LatLng a, LatLng b) {
    final lat1 = a.latitude * pi / 180;
    final lat2 = b.latitude * pi / 180;
    final dLon = (b.longitude - a.longitude) * pi / 180;
    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    return (atan2(y, x) * 180 / pi + 360) % 360;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
