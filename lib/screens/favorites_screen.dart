import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../data/russian_cities.dart';
import '../data/russian_streets.dart';
import '../services/favorites_service.dart';
import '../services/geocoder_service.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatefulWidget {
  final void Function(String name, double lat, double lng)? onNavigate;

  const FavoritesScreen({super.key, this.onNavigate});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<LatLng?> _geocodeAddress(String address) async {
    final q = address.toLowerCase();
    // Search streets first
    for (final s in russianStreets) {
      final full = '${s.street} ${s.city}'.toLowerCase();
      if (q.contains(s.street.toLowerCase()) &&
          q.contains(s.city.toLowerCase())) {
        return LatLng(s.lat, s.lng);
      }
    }
    // Then search cities
    final local = russianCities.where((c) =>
        q.contains(c.name.toLowerCase()) ||
        q.contains(c.region.toLowerCase()));
    if (local.isNotEmpty) {
      return LatLng(local.first.lat, local.first.lng);
    }
    final results = await GeocoderService().search(address);
    if (results.isNotEmpty) {
      return results.first.position;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesService>();
    final settings = context.watch<SettingsService>();
    final isRu = settings.language == AppLanguage.ru;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
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
                  Expanded(
                    child: Text(
                      isRu ? 'Избранное' : 'Favorites',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAddDialog(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add_rounded, color: AppTheme.accent, size: 22),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: favs.places.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bookmark_border_rounded, size: 56, color: sub.withValues(alpha: 0.3)),
                          const SizedBox(height: 12),
                          Text(
                            isRu ? 'Нет избранных мест' : 'No favorites yet',
                            style: TextStyle(color: sub, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isRu
                                ? 'Сохраните дом или работу,\nчтобы быстро добраться'
                                : 'Save home or work\nto get there quickly',
                            style: TextStyle(color: sub.withValues(alpha: 0.6), fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: favs.places.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final place = favs.places[i];
                        return _FavoriteCard(
                          place: place,
                          isDark: isDark,
                          sub: sub,
                          isRu: isRu,
                          onNavigate: () {
                            widget.onNavigate?.call(place.name, place.lat, place.lng);
                            Navigator.of(context).pop();
                          },
                          onDelete: () => favs.remove(place.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    FavoriteIcon selectedIcon = FavoriteIcon.home;
    final settings = context.read<SettingsService>();
    final isRu = settings.language == AppLanguage.ru;
    bool loading = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            isRu ? 'Новое место' : 'New place',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkText : AppTheme.lightText,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    hintText: isRu ? 'Название (напр. Дом)' : 'Name (e.g. Home)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: addressCtrl,
                  decoration: InputDecoration(
                    hintText: isRu ? 'Адрес (напр. ул. Пушкина 1)' : 'Address (e.g. 123 Main St)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _iconBtn(FavoriteIcon.home, Icons.home_rounded, selectedIcon, (v) => setDialogState(() => selectedIcon = v)),
                    const SizedBox(width: 8),
                    _iconBtn(FavoriteIcon.work, Icons.work_rounded, selectedIcon, (v) => setDialogState(() => selectedIcon = v)),
                    const SizedBox(width: 8),
                    _iconBtn(FavoriteIcon.star, Icons.star_rounded, selectedIcon, (v) => setDialogState(() => selectedIcon = v)),
                    const SizedBox(width: 8),
                    _iconBtn(FavoriteIcon.heart, Icons.favorite_rounded, selectedIcon, (v) => setDialogState(() => selectedIcon = v)),
                    const SizedBox(width: 8),
                    _iconBtn(FavoriteIcon.pin, Icons.location_on_rounded, selectedIcon, (v) => setDialogState(() => selectedIcon = v)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(isRu ? 'Отмена' : 'Cancel'),
            ),
            FilledButton(
              onPressed: loading ? null : () async {
                final name = nameCtrl.text.trim();
                final address = addressCtrl.text.trim();
                if (name.isEmpty) return;

                setDialogState(() => loading = true);

                double lat = 55.7519;
                double lng = 37.6178;

                if (address.isNotEmpty) {
                  final pos = await _geocodeAddress(address);
                  if (pos != null) {
                    lat = pos.latitude;
                    lng = pos.longitude;
                  }
                }

                if (!ctx.mounted) return;
                context.read<FavoritesService>().add(
                      name: name,
                      address: address,
                      lat: lat,
                      lng: lng,
                      icon: selectedIcon,
                    );
                Navigator.pop(ctx);
              },
              child: loading
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(isRu ? 'Сохранить' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(FavoriteIcon type, IconData icon, FavoriteIcon selected, ValueChanged<FavoriteIcon> onTap) {
    final isActive = type == selected;
    return GestureDetector(
      onTap: () => onTap(type),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.accent.withValues(alpha: 0.15)
              : AppTheme.accent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10),
          border: isActive ? Border.all(color: AppTheme.accent, width: 2) : null,
        ),
        child: Icon(icon, size: 20, color: AppTheme.accent),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final FavoritePlace place;
  final bool isDark;
  final Color sub;
  final bool isRu;
  final VoidCallback onNavigate;
  final VoidCallback onDelete;

  const _FavoriteCard({
    required this.place,
    required this.isDark,
    required this.sub,
    required this.isRu,
    required this.onNavigate,
    required this.onDelete,
  });

  IconData _getIcon() => switch (place.icon) {
        FavoriteIcon.home => Icons.home_rounded,
        FavoriteIcon.work => Icons.work_rounded,
        FavoriteIcon.star => Icons.star_rounded,
        FavoriteIcon.heart => Icons.favorite_rounded,
        FavoriteIcon.pin => Icons.location_on_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final displayAddress = place.address.isNotEmpty
        ? place.address
        : '${place.lat.toStringAsFixed(4)}, ${place.lng.toStringAsFixed(4)}';

    return Dismissible(
      key: ValueKey(place.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.danger.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_rounded, color: AppTheme.danger),
      ),
      child: GestureDetector(
        onTap: onNavigate,
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
                child: Icon(_getIcon(), color: AppTheme.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      displayAddress,
                      style: TextStyle(fontSize: 12, color: sub),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.accent, Color(0xFF0055D4)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.navigation_rounded, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      isRu ? 'Ехать' : 'Go',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
