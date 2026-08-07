import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../l10n/strings.dart';
import '../services/favorites_service.dart';
import '../services/settings_service.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatefulWidget {
  final void Function(String name, double lat, double lng)? onNavigate;

  const FavoritesScreen({super.key, this.onNavigate});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesService>();
    final settings = context.watch<SettingsService>();
    final isRu = settings.language == AppLanguage.ru;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          isRu ? 'Избранное' : 'Favorites',
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
        actions: [
          IconButton(
            onPressed: () => _showAddDialog(context),
            icon: const Icon(Icons.add_rounded, color: AppTheme.accent),
          ),
        ],
      ),
      body: favs.places.isEmpty
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
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _showAddDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isRu ? 'Добавить место' : 'Add place',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: favs.places.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
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
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final latCtrl = TextEditingController();
    final lngCtrl = TextEditingController();
    FavoriteIcon selectedIcon = FavoriteIcon.home;
    final settings = context.read<SettingsService>();
    final isRu = settings.language == AppLanguage.ru;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(isRu ? 'Новое место' : 'New place'),
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
                  controller: latCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: const InputDecoration(hintText: 'Широта (lat)'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: lngCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: const InputDecoration(hintText: 'Долгота (lng)'),
                ),
                const SizedBox(height: 12),
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
              onPressed: () {
                final name = nameCtrl.text.trim();
                final lat = double.tryParse(latCtrl.text.trim());
                final lng = double.tryParse(lngCtrl.text.trim());
                if (name.isEmpty || lat == null || lng == null) return;
                context.read<FavoritesService>().add(
                      name: name,
                      lat: lat,
                      lng: lng,
                      icon: selectedIcon,
                    );
                Navigator.pop(ctx);
              },
              child: Text(isRu ? 'Сохранить' : 'Save'),
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
                      '${place.lat.toStringAsFixed(4)}, ${place.lng.toStringAsFixed(4)}',
                      style: TextStyle(fontSize: 12, color: sub),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.accent,
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
