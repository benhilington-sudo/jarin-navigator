import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  static const _proxyBase = 'http://127.0.0.1:8081';
  static const _directBase = 'https://api.rasp.yandex.net/v3.0/';
  final String apiKey;
  List<RaspStation>? _cachedStations;

  RaspService(this.apiKey);

  Future<List<RaspStation>> searchStations(String query) async {
    if (query.isEmpty) return [];

    if (_cachedStations != null) {
      return _filterStations(_cachedStations!, query);
    }

    // Пробуем прокси, потом напрямую
    List<RaspStation>? stations;
    if (kIsWeb) {
      stations = await _fetchStationsProxy();
    }
    stations ??= await _fetchStationsDirect();
    if (stations != null) {
      _cachedStations = stations;
      return _filterStations(stations, query);
    }
    return [];
  }

  Future<List<RaspStation>?> _fetchStationsProxy() async {
    try {
      final url = Uri.parse('$_proxyBase/?endpoint=stations&lang=ru_RU');
      final resp = await http.get(url).timeout(const Duration(seconds: 30));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final list = (data['stations'] as List?) ?? [];
        return list.map((s) => RaspStation.fromJson(s as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Proxy error: $e');
    }
    return null;
  }

  Future<List<RaspStation>?> _fetchStationsDirect() async {
    try {
      final url = Uri.parse('$_directBase/stations/?apikey=$_apiKey&lang=ru_RU&format=json');
      final resp = await http.get(url).timeout(const Duration(seconds: 30));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final list = (data['stations'] as List?) ?? [];
        return list.map((s) => RaspStation.fromJson(s as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Direct API error: $e');
    }
    return null;
  }

  List<RaspStation> _filterStations(List<RaspStation> all, String query) {
    final q = query.toLowerCase();
    return all.where((s) {
      final title = s.name.toLowerCase();
      final city = s.city.toLowerCase();
      return title.contains(q) || city.contains(q);
    }).take(30).toList();
  }

  Future<List<RaspSchedule>> getStationSchedule(String stationCode) async {
    if (stationCode.isEmpty) return [];
    if (kIsWeb) {
      final result = await _fetchScheduleProxy(stationCode);
      if (result != null) return result;
    }
    return await _fetchScheduleDirect(stationCode);
  }

  Future<List<RaspSchedule>?> _fetchScheduleProxy(String code) async {
    try {
      final url = Uri.parse('$_proxyBase/?endpoint=station_schedule&station=$code&lang=ru_RU');
      final resp = await http.get(url).timeout(const Duration(seconds: 15));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final list = (data['schedule'] as List?) ?? [];
        return list.map((s) => RaspSchedule.fromJson(s)).toList();
      }
    } catch (e) {
      debugPrint('Proxy schedule error: $e');
    }
    return null;
  }

  Future<List<RaspSchedule>> _fetchScheduleDirect(String code) async {
    try {
      final url = Uri.parse('$_directBase/station_schedule/?apikey=$_apiKey&station=$code&lang=ru_RU&format=json');
      final resp = await http.get(url).timeout(const Duration(seconds: 15));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final list = (data['schedule'] as List?) ?? [];
        return list.map((s) => RaspSchedule.fromJson(s)).toList();
      }
    } catch (e) {
      debugPrint('Direct schedule error: $e');
    }
    return [];
  }
}
