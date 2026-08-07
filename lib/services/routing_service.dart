import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteStepResult {
  final TurnType turn;
  final String streetName;
  final double distanceMeters;
  final double durationSeconds;
  final LatLng location;

  const RouteStepResult({
    required this.turn,
    required this.streetName,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.location,
  });
}

enum TurnType { depart, turnRight, turnLeft, straight, arrive, merge, roundabout, keep }

class RouteResult {
  final List<LatLng> polyline;
  final List<RouteStepResult> steps;
  final double distanceMeters;
  final double durationSeconds;
  final List<TrafficSegment> trafficSegments;

  const RouteResult({
    required this.polyline,
    required this.steps,
    required this.distanceMeters,
    required this.durationSeconds,
    this.trafficSegments = const [],
  });

  int get etaMinutes => (durationSeconds / 60).ceil();
  double get distanceKm => double.parse((distanceMeters / 1000).toStringAsFixed(1));
}

class TrafficSegment {
  final List<LatLng> points;
  final double speedKmh;

  const TrafficSegment({required this.points, required this.speedKmh});
}

class RoutingService {
  static const _base = 'https://router.project-osrm.org/route/v1/driving';

  /// Получить маршрут по реальным дорогам.
  /// [alternatives] = true — вернёт до 3 альтернативных маршрутов.
  Future<List<RouteResult>> getRoutes({
    required LatLng origin,
    required LatLng destination,
    bool alternatives = true,
  }) async {
    try {
      final coords =
          '${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}';
      final uri = Uri.parse(
        '$_base/$coords?overview=full&geometries=geojson&steps=true&annotations=speed'
        '${alternatives ? '&alternatives=true' : ''}',
      );

      final resp = await http
          .get(
            uri,
            headers: {'User-Agent': 'jarin_navigator/1.0 (demo)'},
          )
          .timeout(const Duration(seconds: 10));

      if (resp.statusCode != 200) return const [];

      final data = jsonDecode(resp.body);
      if (data['code'] != 'Ok') return const [];

      final routes = data['routes'] as List;
      return routes.map((r) => _parseRoute(r as Map<String, dynamic>)).toList();
    } catch (e) {
      return const [];
    }
  }

  RouteResult _parseRoute(Map<String, dynamic> json) {
    final geometry = json['geometry'] as Map<String, dynamic>;
    final coords = geometry['coordinates'] as List;

    final polyline = [
      for (final c in coords)
        LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()),
    ];

    final legs = json['legs'] as List;
    final allSteps = <RouteStepResult>[];
    var totalDist = 0.0;
    var totalDur = 0.0;

    for (final leg in legs) {
      totalDist += (leg['distance'] as num).toDouble();
      totalDur += (leg['duration'] as num).toDouble();

      final steps = leg['steps'] as List;
      for (final step in steps) {
        allSteps.add(_parseStep(step as Map<String, dynamic>));
      }
    }

    // Parse traffic from annotations
    final trafficSegments = <TrafficSegment>[];
    for (final leg in legs) {
      final annotations = leg['annotation'] as Map<String, dynamic>?;
      if (annotations != null) {
        final speeds = annotations['speed'] as List?;
        if (speeds != null && polyline.length > 1) {
          final segmentSize = (polyline.length / speeds.length).ceil();
          for (var i = 0; i < speeds.length; i++) {
            final speed = (speeds[i] as num).toDouble();
            final startIdx = (i * segmentSize).clamp(0, polyline.length - 1);
            final endIdx = ((i + 1) * segmentSize).clamp(0, polyline.length);
            if (startIdx < endIdx) {
              trafficSegments.add(TrafficSegment(
                points: polyline.sublist(startIdx, endIdx),
                speedKmh: speed * 3.6,
              ));
            }
          }
        }
      }
    }

    return RouteResult(
      polyline: polyline,
      steps: allSteps,
      distanceMeters: totalDist,
      durationSeconds: totalDur,
      trafficSegments: trafficSegments,
    );
  }

  RouteStepResult _parseStep(Map<String, dynamic> json) {
    final maneuver = json['maneuver'] as Map<String, dynamic>;
    final location = maneuver['location'] as List;
    final type = maneuver['type'] as String;
    final modifier = maneuver['modifier'] as String? ?? 'straight';

    final turn = _mapTurn(type, modifier);

    return RouteStepResult(
      turn: turn,
      streetName: (json['name'] as String?) ?? '',
      distanceMeters: (json['distance'] as num).toDouble(),
      durationSeconds: (json['duration'] as num).toDouble(),
      location: LatLng(
        (location[1] as num).toDouble(),
        (location[0] as num).toDouble(),
      ),
    );
  }

  TurnType _mapTurn(String type, String modifier) {
    if (type == 'arrive') return TurnType.arrive;
    if (type == 'depart') return TurnType.depart;

    switch (modifier) {
      case 'right':
      case 'slight right':
      case 'sharp right':
        return TurnType.turnRight;
      case 'left':
      case 'slight left':
      case 'sharp left':
        return TurnType.turnLeft;
      case 'straight':
        return TurnType.straight;
      case 'uturn':
        return TurnType.turnLeft;
      case 'merge':
        return TurnType.merge;
      default:
        if (type == 'roundabout' || type == 'rotary') {
          return TurnType.roundabout;
        }
        return TurnType.straight;
    }
  }
}
