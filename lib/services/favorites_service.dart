import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FavoriteIcon { home, work, star, heart, pin }

class FavoritePlace {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;
  final FavoriteIcon icon;
  final DateTime createdAt;

  const FavoritePlace({
    required this.id,
    required this.name,
    this.address = '',
    required this.lat,
    required this.lng,
    required this.icon,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'lat': lat,
        'lng': lng,
        'icon': icon.name,
        'createdAt': createdAt.toIso8601String(),
      };

  factory FavoritePlace.fromJson(Map<String, dynamic> j) => FavoritePlace(
        id: j['id'] ?? '',
        name: j['name'] ?? '',
        address: j['address'] ?? '',
        lat: (j['lat'] as num?)?.toDouble() ?? 0,
        lng: (j['lng'] as num?)?.toDouble() ?? 0,
        icon: FavoriteIcon.values.firstWhere(
          (e) => e.name == j['icon'],
          orElse: () => FavoriteIcon.pin,
        ),
        createdAt: DateTime.tryParse(j['createdAt'] ?? '') ?? DateTime.now(),
      );
}

class FavoritesService extends ChangeNotifier {
  List<FavoritePlace> _places = [];
  static const _key = 'jarin_favorites';

  List<FavoritePlace> get places => List.unmodifiable(_places);

  FavoritesService() {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw != null && raw.isNotEmpty) {
        final list = jsonDecode(raw) as List;
        _places = list.map((e) => FavoritePlace.fromJson(e as Map<String, dynamic>)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Favorites load error: $e');
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = jsonEncode(_places.map((e) => e.toJson()).toList());
      await prefs.setString(_key, raw);
    } catch (e) {
      debugPrint('Favorites save error: $e');
    }
  }

  Future<void> add({
    required String name,
    String address = '',
    required double lat,
    required double lng,
    FavoriteIcon icon = FavoriteIcon.pin,
  }) async {
    final place = FavoritePlace(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      address: address,
      lat: lat,
      lng: lng,
      icon: icon,
      createdAt: DateTime.now(),
    );
    _places.insert(0, place);
    notifyListeners();
    await _save();
  }

  Future<void> remove(String id) async {
    _places.removeWhere((e) => e.id == id);
    notifyListeners();
    await _save();
  }

  bool contains(double lat, double lng) {
    return _places.any((e) =>
        (e.lat - lat).abs() < 0.0001 && (e.lng - lng).abs() < 0.0001);
  }
}
