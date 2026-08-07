import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class GeoResult {
  final String name;
  final String address;
  final String type;
  final LatLng position;

  const GeoResult({
    required this.name,
    required this.address,
    required this.type,
    required this.position,
  });

  factory GeoResult.fromJson(Map<String, dynamic> json) {
    final display = (json['display_name'] as String?) ?? '';
    final parts = display.split(',');
    final address = parts.length > 1 ? parts.sublist(1).join(',').trim() : '';
    return GeoResult(
      name: parts.first.trim(),
      address: address,
      type: (json['type'] as String?) ?? 'place',
      position: LatLng(
        double.tryParse(json['lat']?.toString() ?? '') ?? 0,
        double.tryParse(json['lon']?.toString() ?? '') ?? 0,
      ),
    );
  }
}

class GeocoderService {
  static const _base = 'https://nominatim.openstreetmap.org/search';

  /// Поиск только существующих адресов/мест через Nominatim (OpenStreetMap).
  Future<List<GeoResult>> search(String query, {String lang = 'ru'}) async {
    if (query.trim().isEmpty) return const [];
    try {
      final uri = Uri.parse(_base).replace(queryParameters: {
        'q': query,
        'format': 'jsonv2',
        'limit': '8',
        'addressdetails': '0',
        'accept-language': lang,
      });
      final resp = await http.get(
        uri,
        headers: {
          'User-Agent': 'jarin_navigator/1.0 (demo)',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 8));
      if (resp.statusCode != 200) return const [];
      final data = jsonDecode(utf8.decode(resp.bodyBytes)) as List;
      return data
          .map((e) => GeoResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return const [];
    }
  }

  /// Обратное геокодирование: название места по координатам.
  Future<String> reverse(LatLng point, {String lang = 'ru'}) async {
    try {
      final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse',
      ).replace(queryParameters: {
        'lat': '${point.latitude}',
        'lon': '${point.longitude}',
        'format': 'jsonv2',
        'zoom': '16',
        'accept-language': lang,
      });
      final resp = await http.get(
        uri,
        headers: {
          'User-Agent': 'jarin_navigator/1.0 (demo)',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 8));
      if (resp.statusCode != 200) return '';
      final data = jsonDecode(utf8.decode(resp.bodyBytes));
      return (data as Map<String, dynamic>)['display_name'] as String? ?? '';
    } catch (_) {
      return '';
    }
  }
}
