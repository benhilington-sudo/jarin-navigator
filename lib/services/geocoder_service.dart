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
    final parts = display.split(',').map((e) => e.trim()).toList();
    String name = '';
    int addrStart = 1;
    final houseNumbers = <String>[];
    for (var i = 0; i < parts.length; i++) {
      final p = parts[i];
      // Collect house numbers like "4", "12к1" — append to name
      if (RegExp(r'^\d+[а-яА-Я]?\d*$').hasMatch(p)) {
        houseNumbers.add(p);
        addrStart = i + 1;
        continue;
      }
      if (p.length <= 3 && RegExp(r'^\d').hasMatch(p)) {
        houseNumbers.add(p);
        addrStart = i + 1;
        continue;
      }
      name = p;
      addrStart = i + 1;
      break;
    }
    if (name.isEmpty && parts.isNotEmpty) {
      name = parts.first;
      addrStart = 1;
    }
    // Append house number to name: "Берёзовая улица, 4"
    if (houseNumbers.isNotEmpty) {
      name = '$name, ${houseNumbers.join(", ")}';
    }
    final address = parts.length > addrStart
        ? parts.sublist(addrStart).join(', ').trim()
        : '';
    return GeoResult(
      name: name,
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

  /// Expand common Russian abbreviations for better Nominatim results
  static String _normalizeQuery(String q) {
    var s = q.toLowerCase();
    // Common abbreviations → full words
    s = s.replaceAll(RegExp(r'\bул\.?\b'), 'улица');
    s = s.replaceAll(RegExp(r'\bпр-т\.?\b'), 'проспект');
    s = s.replaceAll(RegExp(r'\bпросп\.?\b'), 'проспект');
    s = s.replaceAll(RegExp(r'\bпер\.?\b'), 'переулок');
    s = s.replaceAll(RegExp(r'\bпереул\.?\b'), 'переулок');
    s = s.replaceAll(RegExp(r'\bш\.?\s'), 'шоссе ');
    s = s.replaceAll(RegExp(r'\bнаб\.?\b'), 'набережная');
    s = s.replaceAll(RegExp(r'\bбульв\.?\b'), 'бульвар');
    s = s.replaceAll(RegExp(r'\bпл\.?\b'), 'площадь');
    s = s.replaceAll(RegExp(r'\bпр\.?\b'), 'проспект');
    // Fix common typos
    s = s.replaceAll('зеленна', 'зелёная');
    s = s.replaceAll('зеленная', 'зелёная');
    s = s.replaceAll('чурилково', 'чурилково');
    // Capitalize first letter
    if (s.isNotEmpty) s = s[0].toUpperCase() + s.substring(1);
    return s;
  }

  /// Check if a string contains mostly Cyrillic characters (Russian-looking)
  static bool _looksRussian(String s) {
    if (s.isEmpty) return false;
    var cyrillic = 0;
    var latin = 0;
    for (final ch in s.codeUnits) {
      // Cyrillic: А-Яа-яЁё (0x0400-0x04FF)
      if (ch >= 0x0400 && ch <= 0x04FF) {
        cyrillic++;
      }
      // Latin: A-Za-z (0x0041-0x005A, 0x0061-0x007A)
      if ((ch >= 0x0041 && ch <= 0x005A) || (ch >= 0x0061 && ch <= 0x007A)) {
        latin++;
      }
    }
    // If more Latin than Cyrillic, it's probably an English name like "Cheese Photo"
    return latin == 0 || cyrillic >= latin;
  }

  /// Поиск только существующих адресов/мест через Nominatim (OpenStreetMap).
  /// Если передан [near] — результаты будут ограничены вблизи этих координат (±2°).
  Future<List<GeoResult>> search(
    String query, {
    String lang = 'ru',
    LatLng? near,
  }) async {
    if (query.trim().isEmpty) return const [];
    final normalizedQuery = _normalizeQuery(query);
    try {
      final params = <String, String>{
        'q': normalizedQuery,
        'format': 'jsonv2',
        'limit': '12',
        'addressdetails': '0',
        'accept-language': lang,
      };

      // Ограничиваем поиск вблизи координат (viewbox ±2°)
      if (near != null) {
        final minLon = (near.longitude - 2.0).toStringAsFixed(4);
        final minLat = (near.latitude - 2.0).toStringAsFixed(4);
        final maxLon = (near.longitude + 2.0).toStringAsFixed(4);
        final maxLat = (near.latitude + 2.0).toStringAsFixed(4);
        params['viewbox'] = '$minLon,$minLat,$maxLon,$maxLat';
        params['bounded'] = '0'; // не строго, но приоритет nearby
      }

      final uri = Uri.parse(_base).replace(queryParameters: params);
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
          .where((r) {
        if (r.name.isEmpty) return false;
        // Filter out purely numeric names (house numbers like "4")
        if (RegExp(r'^\d+$').hasMatch(r.name)) return false;
        // Filter out English names like "Cheese Photo"
        return _looksRussian(r.name);
      }).toList();
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
