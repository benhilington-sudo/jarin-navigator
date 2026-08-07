import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class PoiItem {
  final String name;
  final String type;
  final String subtype;
  final double lat;
  final double lng;
  final double? distance;

  const PoiItem({
    required this.name,
    required this.type,
    required this.subtype,
    required this.lat,
    required this.lng,
    this.distance,
  });
}

class PoiService {
  Future<List<PoiItem>> fetchNearby({
    required LatLng center,
    required String category,
    double radiusMeters = 10000,
  }) async {
    final tag = switch (category) {
      'fuel' => 'amenity=fuel',
      'parking' => 'amenity=parking',
      _ => 'amenity=fuel',
    };
    final q = '''
[out:json][timeout:25];
(
  node[$tag](around:$radiusMeters,${center.latitude},${center.longitude});
  way[$tag](around:$radiusMeters,${center.latitude},${center.longitude});
);
out center;
''';
    try {
      // Use local proxy to avoid CORS and rate limits
      final resp = await http.post(
        Uri.parse('http://localhost:8080/proxy/overpass'),
        body: 'data=${Uri.encodeComponent(q)}',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));
      if (resp.statusCode == 200) {
        return _parseResponse(resp.body, category);
      }
    } catch (_) {}
    return [];
  }

  List<PoiItem> _parseResponse(String body, String category) {
    final data = jsonDecode(body);
    final elements = (data['elements'] as List?) ?? [];
    return elements.map((e) {
      final lat = (e['lat'] as num?)?.toDouble() ?? (e['center']?['lat'] as num?)?.toDouble() ?? 0;
      final lon = (e['lon'] as num?)?.toDouble() ?? (e['center']?['lon'] as num?)?.toDouble() ?? 0;
      final tags = e['tags'] as Map<String, dynamic>? ?? {};
      final name = tags['name'] as String? ?? tags['name:ru'] as String? ?? '';
      final brand = tags['brand'] as String? ?? '';
      final network = tags['network'] as String? ?? '';
      final displayName = name.isNotEmpty ? name : (brand.isNotEmpty ? brand : network.isNotEmpty ? network : 'Без названия');
      return PoiItem(
        name: displayName,
        type: category,
        subtype: tags['amenity'] as String? ?? category,
        lat: lat,
        lng: lon,
      );
    }).where((p) => p.lat != 0 && p.lng != 0).toList();
  }

  /// Compute distance for all items after sorting by type
  List<PoiItem> withDistances(LatLng center, List<PoiItem> items) {
    return items.map((p) {
      final dist = _haversine(center, LatLng(p.lat, p.lng));
      return PoiItem(
        name: p.name,
        type: p.type,
        subtype: p.subtype,
        lat: p.lat,
        lng: p.lng,
        distance: dist,
      );
    }).toList()..sort((a, b) => (a.distance ?? 99999).compareTo(b.distance ?? 99999));
  }

  double _haversine(LatLng a, LatLng b) {
    const R = 6371000.0;
    final dLat = (b.latitude - a.latitude) * pi / 180;
    final dLon = (b.longitude - a.longitude) * pi / 180;
    final la1 = a.latitude * pi / 180;
    final la2 = b.latitude * pi / 180;
    final h = (dLat / 2) * (dLat / 2) + cos(la1) * cos(la2) * (dLon / 2) * (dLon / 2);
    return R * 2 * asin(sqrt(h));
  }
}
