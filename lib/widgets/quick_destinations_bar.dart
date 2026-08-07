import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/navigation_engine.dart';
import '../theme/app_theme.dart';

class _RecentDest {
  final String name;
  final String address;
  final double lat;
  final double lon;

  const _RecentDest({
    required this.name,
    required this.address,
    required this.lat,
    required this.lon,
  });
}

class QuickDestinationsBar extends StatefulWidget {
  final void Function(String name, double lat, double lon) onNavigate;

  const QuickDestinationsBar({super.key, required this.onNavigate});

  @override
  State<QuickDestinationsBar> createState() => _QuickDestinationsBarState();
}

class _QuickDestinationsBarState extends State<QuickDestinationsBar> {
  List<_RecentDest> _recent = [];

  @override
  void initState() {
    super.initState();
    _loadRecent();
  }

  Future<void> _loadRecent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList('jarin.recent_searches') ?? [];
      setState(() {
        _recent = raw
            .take(5)
            .map((e) {
              final m = jsonDecode(e) as Map<String, dynamic>;
              return _RecentDest(
                name: m['title'] as String,
                address: m['subtitle'] as String? ?? '',
                lat: (m['lat'] as num).toDouble(),
                lon: (m['lon'] as num).toDouble(),
              );
            })
            .toList();
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<NavigationEngine>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (engine.isActive) return const SizedBox.shrink();

    if (_recent.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 6),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _recent.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final d = _recent[i];
          final dist = const latlong.Distance().as(
            latlong.LengthUnit.Meter,
            engine.position,
            latlong.LatLng(d.lat, d.lon),
          );
          final eta = engine.estimateEta(dist);
          final mins = (eta.inSeconds / 60).ceil();
          return GestureDetector(
            onTap: () => widget.onNavigate(d.name, d.lat, d.lon),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.place_rounded,
                    size: 16,
                    color: AppTheme.accent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    d.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isDark ? AppTheme.darkText : AppTheme.lightText,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$mins мин',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppTheme.accent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
