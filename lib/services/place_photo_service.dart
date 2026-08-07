import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class PlacePhotoService {
  static Future<String?> fetchPhoto({
    required String name,
    required LatLng position,
    String lang = 'ru',
  }) async {
    final wiki = await _searchWikipedia(name, lang);
    if (wiki != null) return wiki;

    final cleanName = _cleanPlaceName(name);
    if (cleanName.isNotEmpty && cleanName != name) {
      final wiki2 = await _searchWikipedia(cleanName, lang);
      if (wiki2 != null) return wiki2;
    }

    final lastPart = name.split(RegExp(r'[,;\s]+')).last;
    if (lastPart.isNotEmpty && lastPart != name && lastPart.length > 2) {
      final wiki3 = await _searchWikipedia(lastPart, lang);
      if (wiki3 != null) return wiki3;
    }

    final commons = await _commonsGeoSearch(position, radius: 3000);
    if (commons != null) return commons;

    return null;
  }

  static String _cleanPlaceName(String name) {
    const prefixes = [
      'деревня', 'село', 'город', 'городок', 'поселок', 'посёлок',
      'пгт', 'п.г.т.', 'станица', 'хутор', 'аул', 'кишлак',
      'слобода', 'местечко', 'станция', 'разъезд', 'кордон',
    ];
    var result = name.trim();
    for (final p in prefixes) {
      if (result.toLowerCase().startsWith('$p ')) {
        result = result.substring(p.length).trim();
        break;
      }
    }
    return result;
  }

  static Future<String?> _searchWikipedia(String query, String lang) async {
    try {
      final title = Uri.encodeComponent(query);
      final url = Uri.parse(
        'https://$lang.wikipedia.org/api/rest_v1/page/summary/$title',
      );
      final resp = await http.get(url).timeout(const Duration(seconds: 6));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final thumb = data['thumbnail']?['source'] as String?;
        if (thumb != null && thumb.isNotEmpty) return thumb;
      }
    } catch (_) {}
    return null;
  }

  static Future<String?> _commonsGeoSearch(LatLng pos, {int radius = 3000}) async {
    try {
      final url = Uri.parse(
        'https://commons.wikimedia.org/w/api.php'
        '?action=query&list=geosearch'
        '&gsradius=$radius&gsnamespace=6'
        '&gscoord=${pos.latitude}|${pos.longitude}'
        '&gslimit=10&format=json',
      );
      final resp = await http.get(url).timeout(const Duration(seconds: 10));
      if (resp.statusCode != 200) return null;
      final data = jsonDecode(resp.body);
      final results = (data['query']?['geosearch'] as List?) ?? [];

      final photoFiles = results.where((r) {
        final t = (r['title'] as String?)?.toLowerCase() ?? '';
        return t.endsWith('.jpg') || t.endsWith('.jpeg') ||
            t.endsWith('.png') || t.endsWith('.gif');
      }).take(3).toList();
      if (photoFiles.isEmpty) return null;

      final titles = photoFiles.map((r) => r['title'] as String).join('|');
      final imgUrl = Uri.parse(
        'https://commons.wikimedia.org/w/api.php'
        '?action=query&titles=${Uri.encodeComponent(titles)}'
        '&prop=imageinfo&iiprop=url|size&iiurlwidth=400&format=json',
      );
      final imgResp = await http.get(imgUrl).timeout(const Duration(seconds: 8));
      if (imgResp.statusCode != 200) return null;
      final imgData = jsonDecode(imgResp.body);
      final pages = imgData['query']?['pages'] as Map<String, dynamic>?;
      if (pages == null) return null;
      for (final p in pages.values) {
        final info = (p['imageinfo'] as List?)?.first;
        if (info != null) {
          final thumb = info['thumburl'] as String?;
          if (thumb != null) return thumb;
        }
      }
    } catch (_) {}
    return null;
  }
}
