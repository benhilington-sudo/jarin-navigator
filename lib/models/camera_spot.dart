import 'package:latlong2/latlong.dart';

enum CameraType { speed, trafficLight, lane, redLight }

class CameraSpot {
  final String id;
  final LatLng position;
  final CameraType type;
  final int speedLimit;

  const CameraSpot({
    required this.id,
    required this.position,
    required this.type,
    this.speedLimit = 60,
  });
}
