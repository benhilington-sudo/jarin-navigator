import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RaspScraperStation {
  final String name;
  final String city;
  final double lat;
  final double lng;
  final String type;

  const RaspScraperStation({
    required this.name,
    required this.city,
    required this.lat,
    required this.lng,
    required this.type,
  });
}

class RaspScraperRoute {
  final String busNumber;
  final String direction;
  final String departure;
  final String arrival;
  final int durationMin;

  const RaspScraperRoute({
    required this.busNumber,
    required this.direction,
    required this.departure,
    required this.arrival,
    required this.durationMin,
  });
}

class RaspScraper {
  static const _baseUrl = 'https://rasp.yandex.ru';

  static Future<List<RaspScraperStation>> searchStations(String query) async {
    if (query.isEmpty) return [];
    try {
      final encoded = Uri.encodeComponent(query);
      final url = Uri.parse('$_baseUrl/search/?type=stop&query=$encoded');
      final resp = await http.get(url, headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Accept': 'text/html',
      }).timeout(const Duration(seconds: 10));

      if (resp.statusCode != 200) return [];

      final html = resp.body;
      return _parseSearchResults(html);
    } catch (e) {
      debugPrint('Scraper search error: $e');
      return [];
    }
  }

  static List<RaspScraperStation> _parseSearchResults(String html) {
    final stations = <RaspScraperStation>[];

    // Ищем JSON-данные в script тегах (rasp.yandex.ru хранит данные в __NEXT_DATA__)
    final nextDataMatch = RegExp(r'<script id="__NEXT_DATA__"[^>]*>(.*?)</script>', dotAll: true).firstMatch(html);
    if (nextDataMatch != null) {
      try {
        final json = jsonDecode(nextDataMatch.group(1)!) as Map<String, dynamic>;
        final props = json['props'] as Map<String, dynamic>?;
        final pageProps = props?['pageProps'] as Map<String, dynamic>?;
        final initialData = pageProps?['initialData'] as Map<String, dynamic>?;
        final stops = initialData?['stops'] as List?;
        if (stops != null) {
          for (final stop in stations) {
            stations.add(RaspScraperStation(
              name: stop.name,
              city: stop.city,
              lat: stop.lat,
              lng: stop.lng,
              type: stop.type,
            ));
          }
        }
      } catch (e) {
        debugPrint('JSON parse error: $e');
      }
    }

    // Fallback: парсим HTML-ссылки
    if (stations.isEmpty) {
      final stopPattern = RegExp(r'href="/station/(\d+)"[^>]*>([^<]+)<');
      for (final match in stopPattern.allMatches(html)) {
        stations.add(RaspScraperStation(
          name: match.group(2)?.trim() ?? '',
          city: '',
          lat: 0,
          lng: 0,
          type: 'stop',
        ));
      }
    }

    return stations.take(30).toList();
  }

  static Future<List<RaspScraperRoute>> getStationSchedule(String stationCode) async {
    if (stationCode.isEmpty) return [];
    try {
      final url = Uri.parse('$_baseUrl/station/$stationCode');
      final resp = await http.get(url, headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Accept': 'text/html',
      }).timeout(const Duration(seconds: 10));

      if (resp.statusCode != 200) return [];

      final html = resp.body;
      return _parseScheduleResults(html);
    } catch (e) {
      debugPrint('Scraper schedule error: $e');
      return [];
    }
  }

  static List<RaspScraperRoute> _parseScheduleResults(String html) {
    final routes = <RaspScraperRoute>[];

    // Парсим таблицу расписания
    final rowPattern = RegExp(r'<tr[^>]*class="[^"]*schedule[^"]*"[^>]*>(.*?)</tr>', dotAll: true);
    for (final rowMatch in rowPattern.allMatches(html)) {
      final row = rowMatch.group(1) ?? '';
      final cells = RegExp(r'<td[^>]*>(.*?)</td>', dotAll: true).allMatches(row).map((m) {
        return m.group(1)?.replaceAll(RegExp(r'<[^>]+>'), '').trim() ?? '';
      }).toList();

      if (cells.length >= 3) {
        routes.add(RaspScraperRoute(
          busNumber: cells.length > 3 ? cells[3] : '',
          direction: cells[0],
          departure: cells.length > 1 ? cells[1] : '',
          arrival: cells.length > 2 ? cells[2] : '',
          durationMin: 0,
        ));
      }
    }

    return routes.take(30).toList();
  }
}
