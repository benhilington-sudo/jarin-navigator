import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/extra_bus_stops.dart';
import '../data/russian_bus_stops.dart';
import '../l10n/strings.dart';
import '../services/rasp_service.dart';
import '../services/rasp_scraper.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class BusRouteDetailScreen extends StatelessWidget {
  final String routeNumber;
  final String direction;
  final String city;
  final List<String> stopNames;
  final int frequencyMinutes;
  final String firstBus;
  final String lastBus;

  const BusRouteDetailScreen({
    super.key,
    required this.routeNumber,
    required this.direction,
    required this.city,
    required this.stopNames,
    required this.frequencyMinutes,
    required this.firstBus,
    required this.lastBus,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;
    final settings = context.watch<SettingsService>();
    final isRu = settings.language == AppLanguage.ru;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          isRu ? 'Маршрут $routeNumber' : 'Route $routeNumber',
          style: TextStyle(
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? AppTheme.darkText : AppTheme.lightText,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      routeNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: AppTheme.accent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        direction,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        city,
                        style: TextStyle(fontSize: 12, color: sub),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.success.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _scheduleChip(
                  isRu ? 'Интервал' : 'Interval',
                  '$frequencyMinutes ${isRu ? "мин" : "min"}',
                  Icons.schedule_rounded,
                  isDark,
                  sub,
                ),
                _scheduleChip(
                  isRu ? 'Первый' : 'First',
                  firstBus,
                  Icons.wb_sunny_rounded,
                  isDark,
                  sub,
                ),
                _scheduleChip(
                  isRu ? 'Последний' : 'Last',
                  lastBus,
                  Icons.nights_stay_rounded,
                  isDark,
                  sub,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  isRu ? 'Остановки на маршруте' : 'Stops on route',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${stopNames.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: stopNames.length,
              separatorBuilder: (_, _i) {
                if (_i >= stopNames.length - 1) return const SizedBox.shrink();
                return Row(
                  children: [
                    const SizedBox(width: 19),
                    Container(
                      width: 2,
                      height: 20,
                      color: AppTheme.accent.withValues(alpha: 0.25),
                    ),
                  ],
                );
              },
              itemBuilder: (context, i) {
                final isFirst = i == 0;
                final isLast = i == stopNames.length - 1;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFirst || isLast
                                ? AppTheme.accent
                                : AppTheme.accent.withValues(alpha: 0.4),
                            border: Border.all(
                              color: AppTheme.accent,
                              width: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isFirst || isLast
                              ? AppTheme.accent.withValues(alpha: 0.06)
                              : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isFirst || isLast
                                ? AppTheme.accent.withValues(alpha: 0.2)
                                : (isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${i + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isFirst || isLast
                                    ? AppTheme.accent
                                    : sub,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                stopNames[i],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isFirst || isLast
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                                ),
                              ),
                            ),
                            if (isFirst)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.success.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  isRu ? 'начало' : 'start',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.success,
                                  ),
                                ),
                              ),
                            if (isLast)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.danger.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  isRu ? 'конец' : 'end',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.danger,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _scheduleChip(String label, String value, IconData icon, bool isDark, Color sub) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppTheme.accent),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: sub),
        ),
      ],
    );
  }
}

class BusStopScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const BusStopScreen({super.key, this.onBack});

  @override
  State<BusStopScreen> createState() => _BusStopScreenState();
}

class _BusStopScreenState extends State<BusStopScreen> with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  String _selectedCity = '';
  int _selectedTab = 0;
  List<BusStop> _stopResults = [];
  List<_RouteInfo> _routeResults = [];
  List<String> _cities = [];
  bool _showCityPicker = false;

  // Яндекс Расписания
  static const _raspApiKey = '7563729e-960d-44e9-8b80-4a17538f6200';
  final RaspService _rasp = RaspService('7563729e-960d-44e9-8b80-4a17538f6200');
  List<RaspStation> _raspStations = [];
  List<RaspSchedule> _raspSchedule = [];
  bool _raspLoading = false;
  RaspStation? _selectedRaspStation;

  static final _allStops = [...russianBusStops, ...extraBusStops];

  @override
  void initState() {
    super.initState();
    _cities = _allStops.map((s) => s.city).toSet().toList()..sort();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) {
      setState(() {
        _stopResults = [];
        _routeResults = [];
        _raspStations = [];
      });
      return;
    }

    if (_selectedTab == 0) {
      setState(() {
        _stopResults = _allStops.where((stop) {
          final matchName = stop.name.toLowerCase().contains(q);
          final matchDistrict = stop.district.toLowerCase().contains(q);
          final matchCity = _selectedCity.isEmpty || stop.city == _selectedCity;
          return (matchName || matchDistrict) && matchCity;
        }).toList();
      });
    } else if (_selectedTab == 1) {
      setState(() {
        final matchingStops = _allStops.where((stop) {
          final matchCity = _selectedCity.isEmpty || stop.city == _selectedCity;
          return matchCity && stop.routes.any((r) => r.number.toLowerCase().contains(q));
        }).toList();

        final routeMap = <String, _RouteInfo>{};
        for (final stop in matchingStops) {
          for (final route in stop.routes) {
            if (route.number.toLowerCase().contains(q)) {
              final key = '${route.number}_${route.direction}_${stop.city}';
              if (routeMap.containsKey(key)) {
                routeMap[key]!.stopNames.add(stop.name);
              } else {
                routeMap[key] = _RouteInfo(
                  number: route.number,
                  direction: route.direction,
                  city: stop.city,
                  stopNames: [stop.name],
                  frequencyMinutes: route.frequencyMinutes,
                  firstBus: route.firstBus,
                  lastBus: route.lastBus,
                );
              }
            }
          }
        }
        _routeResults = routeMap.values.toList();
      });
    } else {
      _searchYandex(query);
    }
  }

  Future<void> _searchYandex(String query) async {
    setState(() {
      _raspLoading = true;
      _raspStations = [];
    });

    // 1. Try API first
    var results = await _rasp.searchStations(query);

    // 2. If no results, try scraper
    if (results.isEmpty) {
      final scraped = await RaspScraper.searchStations(query);
      if (scraped.isNotEmpty) {
        results = scraped.map((s) => RaspStation(
          code: '',
          name: s.name,
          city: s.city,
          region: '',
          lat: s.lat,
          lng: s.lng,
          stationType: s.type,
        )).toList();
      }
    }

    // 3. If still nothing, try offline stops as last resort
    if (results.isEmpty) {
      final offlineResults = _allStops.where((stop) {
        return stop.name.toLowerCase().contains(query.toLowerCase());
      }).take(20).toList();
      if (offlineResults.isNotEmpty) {
        results = offlineResults.map((s) => RaspStation(
          code: '',
          name: s.name,
          city: s.city,
          region: s.district,
          lat: s.lat,
          lng: s.lng,
          stationType: 'stop',
        )).toList();
      }
    }

    if (mounted) {
      setState(() {
        _raspStations = results;
        _raspLoading = false;
      });
    }
  }

  Future<void> _loadSchedule(RaspStation station) async {
    setState(() {
      _selectedRaspStation = station;
      _raspLoading = true;
      _raspSchedule = [];
    });
    final schedule = await _rasp.getStationSchedule(station.code);
    if (mounted) {
      setState(() {
        _raspSchedule = schedule;
        _raspLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final s = settings.strings;
    final isRu = settings.language == AppLanguage.ru;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            if (widget.onBack != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onBack,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkCard : const Color(0xFFF2F2F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 22,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showCityPicker = !_showCityPicker),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_city_rounded, size: 18, color: AppTheme.accent),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _selectedCity.isEmpty
                                    ? (isRu ? 'Все города' : 'All cities')
                                    : _selectedCity,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                                ),
                              ),
                            ),
                            Icon(Icons.unfold_more_rounded, size: 16, color: sub),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_showCityPicker) ...[
              Container(
                height: 200,
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _cities.length + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return ListTile(
                        dense: true,
                        title: Text(
                          isRu ? 'Все города' : 'All cities',
                          style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCity = '';
                            _showCityPicker = false;
                          });
                          _search(_controller.text);
                        },
                      );
                    }
                    final city = _cities[i - 1];
                    return ListTile(
                      dense: true,
                      title: Text(city),
                      trailing: _selectedCity == city
                          ? const Icon(Icons.check_circle_rounded, color: AppTheme.accent, size: 18)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedCity = city;
                          _showCityPicker = false;
                        });
                        _search(_controller.text);
                      },
                    );
                  },
                ),
              ),
            ],
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedTab = 0);
                        _search(_controller.text);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0
                              ? AppTheme.accent.withValues(alpha: 0.12)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(11),
                            bottomLeft: Radius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_bus_rounded,
                              size: 18,
                              color: _selectedTab == 0
                                  ? AppTheme.accent
                                  : sub,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isRu ? 'Остановки' : 'Stops',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: _selectedTab == 0 ? FontWeight.w600 : FontWeight.w400,
                                color: _selectedTab == 0
                                    ? AppTheme.accent
                                    : sub,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedTab = 1);
                        _search(_controller.text);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1
                              ? AppTheme.accent.withValues(alpha: 0.12)
                              : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alt_route_rounded,
                              size: 18,
                              color: _selectedTab == 1
                                  ? AppTheme.accent
                                  : sub,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isRu ? 'Маршруты' : 'Routes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: _selectedTab == 1 ? FontWeight.w600 : FontWeight.w400,
                                color: _selectedTab == 1
                                    ? AppTheme.accent
                                    : sub,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 2;
                          _selectedRaspStation = null;
                          _raspSchedule = [];
                        });
                        _search(_controller.text);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 2
                              ? AppTheme.accent.withValues(alpha: 0.12)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(11),
                            bottomRight: Radius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_download_rounded,
                              size: 18,
                              color: _selectedTab == 2
                                  ? AppTheme.accent
                                  : sub,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Яндекс+',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: _selectedTab == 2 ? FontWeight.w600 : FontWeight.w400,
                                color: _selectedTab == 2
                                    ? AppTheme.accent
                                    : sub,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: TextField(
                controller: _controller,
                autofocus: false,
                textInputAction: TextInputAction.search,
                onChanged: _search,
                decoration: InputDecoration(
                  hintText: _selectedTab == 0
                      ? (isRu ? 'Поиск остановки…' : 'Search stop…')
                      : _selectedTab == 1
                          ? (isRu ? 'Номер маршрута (напр. 1, 15, М1)…' : 'Route number (e.g. 1, 15, M1)…')
                          : (isRu ? 'Поиск станции Яндекс…' : 'Search Yandex station…'),
                  prefixIcon: const Icon(Icons.search_rounded, size: 22),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _controller.clear();
                            _search('');
                          },
                          icon: const Icon(Icons.close_rounded, size: 20),
                        )
                      : null,
                ),
              ),
            ),
            Expanded(
              child: _selectedTab == 0
                  ? (_stopResults.isEmpty
                      ? _buildEmpty(sub, s, isRu)
                      : _buildStopResults(isDark, sub, isRu))
                  : _selectedTab == 1
                      ? (_routeResults.isEmpty
                          ? _buildEmptyRoutes(sub, s, isRu)
                          : _buildRouteResults(isDark, sub, isRu))
                      : _buildYandexResults(isDark, sub, isRu),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(Color sub, Strings s, bool isRu) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.directions_bus_rounded, size: 56, color: sub.withValues(alpha: 0.3)),
          const SizedBox(height: 12),
          Text(
            isRu ? 'Найдите остановку' : 'Find a stop',
            style: TextStyle(color: sub, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            '${_allStops.length} ${isRu ? "остановок по всей России" : "stops across Russia"}',
            style: TextStyle(color: sub.withValues(alpha: 0.6), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyRoutes(Color sub, Strings s, bool isRu) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alt_route_rounded, size: 56, color: sub.withValues(alpha: 0.3)),
          const SizedBox(height: 12),
          Text(
            isRu ? 'Найдите маршрут' : 'Find a route',
            style: TextStyle(color: sub, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            isRu ? 'Введите номер маршрута' : 'Enter route number',
            style: TextStyle(color: sub.withValues(alpha: 0.6), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildStopResults(bool isDark, Color sub, bool isRu) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _stopResults.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (context, i) => _StopCard(
        stop: _stopResults[i],
        allStops: _allStops,
        isDark: isDark,
        sub: sub,
        isRu: isRu,
      ),
    );
  }

  Widget _buildRouteResults(bool isDark, Color sub, bool isRu) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _routeResults.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (context, i) => _RouteCard(
        routeInfo: _routeResults[i],
        isDark: isDark,
        sub: sub,
        isRu: isRu,
      ),
    );
  }

  Widget _buildYandexResults(bool isDark, Color sub, bool isRu) {
    if (_raspLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    // Если выбрана станция — показываем расписание
    if (_selectedRaspStation != null) {
      return _buildScheduleList(isDark, sub, isRu);
    }

    // Иначе — список найденных станций
    if (_raspStations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_rounded, size: 56, color: sub.withValues(alpha: 0.3)),
              const SizedBox(height: 12),
              Text(
                isRu ? 'Поиск остановок и маршрутов' : 'Search stops and routes',
                style: TextStyle(color: sub, fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                isRu
                    ? 'Введите название остановки или номер маршрута.\nРаботает из Яндекс Расписаний, парсера или локальной базы.'
                    : 'Enter stop name or route number.\nWorks from Yandex Schedule, parser, or local database.',
                style: TextStyle(color: sub.withValues(alpha: 0.6), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _raspStations.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (context, i) {
        final station = _raspStations[i];
        return GestureDetector(
          onTap: () => _loadSchedule(station),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.accent.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.cloud_download_rounded, color: AppTheme.accent, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${station.city.isNotEmpty ? station.city : station.region} • ${station.stationType}',
                        style: TextStyle(fontSize: 12, color: sub),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: sub, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScheduleList(bool isDark, Color sub, bool isRu) {
    final station = _selectedRaspStation!;
    return Column(
      children: [
        // Шапка станции
        Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _selectedRaspStation = null;
                  _raspSchedule = [];
                }),
                child: const Icon(Icons.arrow_back_rounded, color: AppTheme.accent, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                    Text(
                      station.city.isNotEmpty ? station.city : station.region,
                      style: TextStyle(fontSize: 12, color: sub),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Список расписания
        Expanded(
          child: _raspSchedule.isEmpty
              ? Center(
                  child: Text(
                    isRu ? 'Нет данных о расписании' : 'No schedule data',
                    style: TextStyle(color: sub),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: _raspSchedule.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4),
                  itemBuilder: (context, i) {
                    final s = _raspSchedule[i];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              s.direction.length > 20
                                  ? '${s.direction.substring(0, 20)}…'
                                  : s.direction,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppTheme.accent,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${s.departure} → ${s.arrival}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                                  ),
                                ),
                                Text(
                                  s.carrier,
                                  style: TextStyle(fontSize: 11, color: sub),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _RouteInfo {
  final String number;
  final String direction;
  final String city;
  final List<String> stopNames;
  final int frequencyMinutes;
  final String firstBus;
  final String lastBus;

  _RouteInfo({
    required this.number,
    required this.direction,
    required this.city,
    required this.stopNames,
    required this.frequencyMinutes,
    required this.firstBus,
    required this.lastBus,
  });
}

class _StopCard extends StatelessWidget {
  final BusStop stop;
  final List<BusStop> allStops;
  final bool isDark;
  final Color sub;
  final bool isRu;

  const _StopCard({
    required this.stop,
    required this.allStops,
    required this.isDark,
    required this.sub,
    required this.isRu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.alt_route_rounded,
                  color: AppTheme.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${stop.city}, ${stop.district}',
                      style: TextStyle(fontSize: 12, color: sub),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: stop.routes.map((route) {
              final nextMin = _calcNextArrival(route);
              return GestureDetector(
                onTap: () {
                  final stopsOnRoute = allStops
                      .where((s) => s.city == stop.city && s.routes.any((r) => r.number == route.number))
                      .map((s) => s.name)
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BusRouteDetailScreen(
                        routeNumber: route.number,
                        direction: route.direction,
                        city: stop.city,
                        stopNames: stopsOnRoute,
                        frequencyMinutes: route.frequencyMinutes,
                        firstBus: route.firstBus,
                        lastBus: route.lastBus,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        route.number,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppTheme.accent,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '→ ${route.direction}',
                        style: TextStyle(fontSize: 11, color: sub),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: nextMin <= 3
                              ? AppTheme.success.withValues(alpha: 0.15)
                              : AppTheme.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          nextMin <= 1
                              ? (isRu ? 'сейчас' : 'now')
                              : '$nextMin мин',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: nextMin <= 3 ? AppTheme.success : AppTheme.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 6),
          Text(
            '${isRu ? "Каждые" : "Every"} ${stop.routes.isNotEmpty ? stop.routes.first.frequencyMinutes : 15} ${isRu ? "мин" : "min"} • ${stop.routes.first.firstBus}–${stop.routes.first.lastBus}',
            style: TextStyle(fontSize: 11, color: sub.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  int _calcNextArrival(BusRoute route) {
    final now = DateTime.now();
    final minutes = now.hour * 60 + now.minute;
    final freq = route.frequencyMinutes;
    final next = ((minutes ~/ freq) + 1) * freq;
    return (next - minutes).clamp(1, freq);
  }
}

class _RouteCard extends StatelessWidget {
  final _RouteInfo routeInfo;
  final bool isDark;
  final Color sub;
  final bool isRu;

  const _RouteCard({
    required this.routeInfo,
    required this.isDark,
    required this.sub,
    required this.isRu,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BusRouteDetailScreen(
              routeNumber: routeInfo.number,
              direction: routeInfo.direction,
              city: routeInfo.city,
              stopNames: routeInfo.stopNames,
              frequencyMinutes: routeInfo.frequencyMinutes,
              firstBus: routeInfo.firstBus,
              lastBus: routeInfo.lastBus,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      routeInfo.number,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: AppTheme.accent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routeInfo.direction,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        routeInfo.city,
                        style: TextStyle(fontSize: 12, color: sub),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: sub, size: 22),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _infoChip(
                  Icons.schedule_rounded,
                  '${routeInfo.frequencyMinutes} ${isRu ? "мин" : "min"}',
                  isDark,
                  sub,
                ),
                _infoChip(
                  Icons.wb_sunny_rounded,
                  routeInfo.firstBus,
                  isDark,
                  sub,
                ),
                _infoChip(
                  Icons.nights_stay_rounded,
                  routeInfo.lastBus,
                  isDark,
                  sub,
                ),
                _infoChip(
                  Icons.stop_rounded,
                  '${routeInfo.stopNames.length} ${isRu ? "ост." : "stops"}',
                  isDark,
                  sub,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text, bool isDark, Color sub) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppTheme.accent),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
          ),
        ),
      ],
    );
  }
}
