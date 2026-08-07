import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/strings.dart';
import '../services/geocoder_service.dart';
import '../services/navigation_engine.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class _SearchItem {
  final String title;
  final String subtitle;
  final LatLng position;
  final IconData icon;
  final Color color;
  final bool remote;

  const _SearchItem({
    required this.title,
    required this.subtitle,
    required this.position,
    required this.icon,
    required this.color,
    this.remote = false,
  });
}

class SearchScreen extends StatefulWidget {
  final void Function() onNavigate;
  final VoidCallback? onBack;

  const SearchScreen({super.key, required this.onNavigate, this.onBack});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _geocoder = GeocoderService();
  Timer? _debounce;
  List<_SearchItem> _results = [];
  bool _searching = false;
  bool _loading = false;
  bool _geocodeError = false;
  List<_SearchItem> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onQueryChanged);
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList('jarin.recent_searches') ?? [];
      setState(() {
        _recentSearches = raw
            .map((e) {
              final m = jsonDecode(e) as Map<String, dynamic>;
              return _SearchItem(
                title: m['title'] as String,
                subtitle: m['subtitle'] as String? ?? '',
                position: LatLng(
                  (m['lat'] as num).toDouble(),
                  (m['lon'] as num).toDouble(),
                ),
                icon: Icons.history_rounded,
                color: AppTheme.lightSubtext,
                remote: true,
              );
            })
            .toList()
            .take(5)
            .toList();
      });
    } catch (_) {}
  }

  Future<void> _saveRecentSearch(_SearchItem item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList('jarin.recent_searches') ?? [];
      final entry = jsonEncode({
        'title': item.title,
        'subtitle': item.subtitle,
        'lat': item.position.latitude,
        'lon': item.position.longitude,
      });
      raw.remove(entry);
      raw.insert(0, entry);
      if (raw.length > 10) raw.removeRange(10, raw.length);
      await prefs.setStringList('jarin.recent_searches', raw);
    } catch (_) {}
  }

  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => _runSearch());
  }

  Future<void> _runSearch() async {
    final q = _controller.text.trim();
    if (q.isEmpty) {
      setState(() {
        _searching = false;
        _loading = false;
        _results = [];
      });
      return;
    }

    setState(() {
      _searching = true;
      _loading = true;
      _geocodeError = false;
      _results = [];
    });

    final isRu =
        context.read<SettingsService>().language == AppLanguage.ru;
    final remote = await _geocoder.search(q, lang: isRu ? 'ru' : 'en');
    if (!mounted || _controller.text.trim() != q) return;

    final remoteItems = [
      for (final r in remote)
        _SearchItem(
          title: r.name,
          subtitle: r.address,
          position: r.position,
          icon: Icons.place_rounded,
          color: AppTheme.accent,
          remote: true,
        ),
    ];

    setState(() {
      _loading = false;
      _geocodeError = remote.isEmpty;
      _results = remoteItems;
    });
  }

  void _startNavigation(_SearchItem item) {
    final engine = context.read<NavigationEngine>();
    _saveRecentSearch(item);
    engine.findRoutes(
      destination: item.position,
      name: item.title,
    );
    widget.onNavigate();
  }

  String _formatEta(double meters) {
    final engine = context.read<NavigationEngine>();
    final s = context.read<SettingsService>().strings;
    final eta = engine.estimateEta(meters);
    final minutes = max(1, (eta.inSeconds / 60).ceil());
    return '$minutes ${s.minutesShort}';
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsService>().strings;
    final engine = context.watch<NavigationEngine>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Поисковая строка
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
              child: Row(
                children: [
                  if (widget.onBack != null)
                    GestureDetector(
                      onTap: widget.onBack,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppTheme.darkCard
                              : const Color(0xFFF2F2F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 22,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        ),
                      ),
                    ),
                  if (widget.onBack != null) const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: s.searchPlaceholder,
                        prefixIcon: const Icon(Icons.search_rounded, size: 22),
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  setState(() {
                                    _searching = false;
                                    _results = [];
                                  });
                                },
                                icon: const Icon(Icons.close_rounded, size: 20),
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Результаты
            Expanded(
              child: _searching
                  ? _buildResults(s, sub, engine)
                  : _buildRecent(s, sub, engine),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(Strings s, Color sub, NavigationEngine engine) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _geocodeError ? Icons.search_off_rounded : Icons.location_on_outlined,
              size: 48,
              color: sub.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 12),
            Text(
              _geocodeError ? 'Ничего не найдено' : s.searchPlaceholder,
              style: TextStyle(color: sub, fontSize: 15),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: _results.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final item = _results[i];
        final dist = const Distance()
            .as(LengthUnit.Meter, engine.position, item.position);
        return _ResultTile(
          title: item.title,
          subtitle: item.subtitle,
          icon: item.icon,
          color: item.color,
          eta: '${s.routeTime} ${_formatEta(dist)}',
          onTap: () => _startNavigation(item),
        );
      },
    );
  }

  Widget _buildRecent(Strings s, Color sub, NavigationEngine engine) {
    if (_recentSearches.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_rounded,
              size: 48,
              color: sub.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 12),
            Text(
              s.searchPlaceholder,
              style: TextStyle(color: sub, fontSize: 15),
            ),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            context.read<SettingsService>().language == AppLanguage.ru
                ? 'Недавние'
                : 'Recent',
            style: TextStyle(
              color: sub,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        for (final item in _recentSearches)
          _ResultTile(
            title: item.title,
            subtitle: item.subtitle,
            icon: Icons.history_rounded,
            color: sub,
            eta: '',
            onTap: () => _startNavigation(item),
          ),
      ],
    );
  }
}

class _ResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String eta;
  final VoidCallback onTap;

  const _ResultTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.eta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? AppTheme.darkText : AppTheme.lightText,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: sub,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: eta.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                eta,
                style: const TextStyle(
                  color: AppTheme.accent,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            )
          : null,
    );
  }
}
