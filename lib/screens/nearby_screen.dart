import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/navigation_engine.dart';
import '../services/poi_service.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class NearbyScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final void Function(String name, double lat, double lng)? onNavigate;

  const NearbyScreen({super.key, this.onBack, this.onNavigate});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  int _tab = 0;
  List<PoiItem> _items = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final engine = context.read<NavigationEngine>();
    final pos = engine.position;
    setState(() {
      _loading = true;
    });
    final category = _tab == 0 ? 'fuel' : 'parking';
    final items = await PoiService().fetchNearby(center: pos, category: category);
    final withDist = PoiService().withDistances(pos, items);
    if (mounted) {
      setState(() {
        _items = withDist;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 22,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isRu ? 'Поблизости' : 'Nearby',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  _TabBtn(
                    icon: Icons.local_gas_station_rounded,
                    label: isRu ? 'Заправки' : 'Gas',
                    active: _tab == 0,
                    onTap: () {
                      setState(() => _tab = 0);
                      _load();
                    },
                    isDark: isDark,
                    sub: sub,
                    first: true,
                  ),
                  Container(width: 1, height: 24, color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
                  _TabBtn(
                    icon: Icons.local_parking_rounded,
                    label: isRu ? 'Парковки' : 'Parking',
                    active: _tab == 1,
                    onTap: () {
                      setState(() => _tab = 1);
                      _load();
                    },
                    isDark: isDark,
                    sub: sub,
                    first: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
                  : _items.isEmpty
                      ? _buildEmpty(sub, isRu)
                      : _buildList(isDark, sub, isRu),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(Color sub, bool isRu) {
    final icon = _tab == 0 ? Icons.local_gas_station_rounded : Icons.local_parking_rounded;
    final title = _tab == 0
        ? (isRu ? 'Нет заправок поблизости' : 'No gas stations nearby')
        : (isRu ? 'Нет парковок поблизости' : 'No parking nearby');
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: sub.withValues(alpha: 0.3)),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: sub, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            isRu ? 'Подвиньтесь ближе или\nобновите поиск' : 'Move closer or\nrefresh search',
            style: TextStyle(color: sub.withValues(alpha: 0.6), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildList(bool isDark, Color sub, bool isRu) {
    return RefreshIndicator(
      onRefresh: _load,
      color: AppTheme.accent,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        itemCount: _items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 4),
        itemBuilder: (context, i) {
          final item = _items[i];
          final distText = _formatDistance(item.distance);
          final icon = _tab == 0 ? Icons.local_gas_station_rounded : Icons.local_parking_rounded;

          return GestureDetector(
            onTap: () => widget.onNavigate?.call(item.name, item.lat, item.lng),
            child: Container(
              padding: const EdgeInsets.all(14),
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
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppTheme.accent, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
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
                          '${item.lat.toStringAsFixed(5)}, ${item.lng.toStringAsFixed(5)}',
                          style: TextStyle(fontSize: 12, color: sub),
                        ),
                      ],
                    ),
                  ),
                  if (distText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.accent, Color(0xFF0055D4)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        distText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
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

  String? _formatDistance(double? meters) {
    if (meters == null) return null;
    if (meters < 1000) return '${meters.round()} м';
    return '${(meters / 1000).toStringAsFixed(1)} км';
  }
}

class _TabBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final bool isDark;
  final Color sub;
  final bool first;

  const _TabBtn({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    required this.isDark,
    required this.sub,
    required this.first,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? AppTheme.accent.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(first ? 11 : 0),
              bottomLeft: Radius.circular(first ? 11 : 0),
              topRight: Radius.circular(!first ? 11 : 0),
              bottomRight: Radius.circular(!first ? 11 : 0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: active ? AppTheme.accent : sub),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? AppTheme.accent : sub,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
