import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/navigation_engine.dart';

class RouteHistory {
  static const _kHistory = 'jarin.route_history';
  static const _kFavorites = 'jarin.favorites';
  static const _maxHistory = 20;

  late SharedPreferences _prefs;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<SavedRoute> getHistory() {
    final raw = _prefs.getStringList(_kHistory) ?? [];
    return raw
        .map((e) => SavedRoute.fromMap(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  List<SavedRoute> getFavorites() {
    final raw = _prefs.getStringList(_kFavorites) ?? [];
    return raw
        .map((e) => SavedRoute.fromMap(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> addRoute(SavedRoute route) async {
    final history = getHistory();
    history.removeWhere((r) =>
        r.lat == route.lat && r.lon == route.lon && r.name == route.name);
    history.insert(0, route);
    if (history.length > _maxHistory) {
      history.removeRange(_maxHistory, history.length);
    }
    final encoded = history.map((r) => jsonEncode(r.toMap())).toList();
    await _prefs.setStringList(_kHistory, encoded);
  }

  Future<void> addFavorite(SavedRoute route) async {
    final favorites = getFavorites();
    if (favorites.any((r) => r.lat == route.lat && r.lon == route.lon)) return;
    favorites.add(route);
    final encoded = favorites.map((r) => jsonEncode(r.toMap())).toList();
    await _prefs.setStringList(_kFavorites, encoded);
  }

  Future<void> removeFavorite(SavedRoute route) async {
    final favorites = getFavorites();
    favorites.removeWhere(
        (r) => r.lat == route.lat && r.lon == route.lon && r.name == route.name);
    final encoded = favorites.map((r) => jsonEncode(r.toMap())).toList();
    await _prefs.setStringList(_kFavorites, encoded);
  }

  Future<void> clearHistory() async {
    await _prefs.remove(_kHistory);
  }
}
