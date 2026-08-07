import 'dart:convert';

import 'package:http/http.dart' as http;

class RaspStation {
  final String code;
  final String name;
  final String city;
  final String region;
  final double lat;
  final double lng;
  final String stationType;

  const RaspStation({
    required this.code,
    required this.name,
    required this.city,
    required this.region,
    required this.lat,
    required this.lng,
    required this.stationType,
  });

  factory RaspStation.fromJson(Map<String, dynamic> j) {
    final coords = j['coords'] ?? {};
    final cityObj = j['city'];
    final regionObj = j['region'];
    return RaspStation(
      code: j['code'] ?? '',
      name: j['title'] ?? '',
      city: cityObj != null ? cityObj['title'] ?? '' : '',
      region: regionObj != null ? regionObj['title'] ?? '' : '',
      lat: (coords['lat'] as num?)?.toDouble() ?? 0,
      lng: (coords['lng'] as num?)?.toDouble() ?? 0,
      stationType: j['station_type'] ?? '',
    );
  }
}

class RaspSchedule {
  final String direction;
  final String carrier;
  final String departure;
  final String arrival;
  final int duration;

  const RaspSchedule({
    required this.direction,
    required this.carrier,
    required this.departure,
    required this.arrival,
    required this.duration,
  });

  factory RaspSchedule.fromJson(Map<String, dynamic> j) {
    final dep = j['departure'] ?? '';
    final arr = j['arrival'] ?? '';
    final carrierObj = j['carrier'];
    final thread = j['thread'] ?? {};
    return RaspSchedule(
      direction: thread['title'] ?? '',
      carrier: carrierObj is Map ? carrierObj['title'] ?? '' : '',
      departure: dep is String && dep.length >= 16 ? dep.substring(11, 16) : '',
      arrival: arr is String && arr.length >= 16 ? arr.substring(11, 16) : '',
      duration: j['duration'] ?? 0,
    );
  }
}

class RaspService {
  static const _apiKey = '7563729e-960d-44e9-8b80-4a17538f6200';
  static const _proxy = 'http://127.0.0.1:8080/proxy/rasp';

  RaspService(String _ignored);

  Future<List<RaspStation>> searchStations(String query) async {
    if (query.trim().length < 2) return [];
    try {
      final q = Uri.encodeComponent(query);
      final url = Uri.parse('$_proxy/suggest/?apikey=$_apiKey&query=$q&type=station&lang=ru_RU&format=json');
      final resp = await http.get(url).timeout(const Duration(seconds: 15));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final list = (data['stations'] as List?) ?? [];
        return list.map((s) => RaspStation.fromJson(s as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      // ignore
    }
    return [];
  }

  Future<List<RaspSchedule>> getStationSchedule(String stationCode) async {
    if (stationCode.isEmpty) return [];
    try {
      final url = Uri.parse('$_proxy/station_schedule/?apikey=$_apiKey&station=$stationCode&lang=ru_RU&format=json');
      final resp = await http.get(url).timeout(const Duration(seconds: 15));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final list = (data['schedule'] as List?) ?? [];
        return list.map((s) => RaspSchedule.fromJson(s as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      // ignore
    }
    return [];
  }
}
