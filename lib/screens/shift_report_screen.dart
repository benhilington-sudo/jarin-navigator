import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
import '../services/shift_report_service.dart';
import '../theme/app_theme.dart';

class ShiftReportScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ShiftReportScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final shift = context.watch<ShiftReportService>();
    final isDark = settings.themeMode == ThemeMode.dark;
    final isRu = settings.language == AppLanguage.ru;
    final s = settings.strings;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack,
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
                      isRu ? 'Отчёт за смену' : 'Shift Report',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Shift status card
                  _ShiftCard(isDark: isDark, isRu: isRu, shift: shift),
                  const SizedBox(height: 16),

                  // Stats grid
                  Row(
                    children: [
                      Expanded(child: _StatBox(
                        icon: Icons.straighten_rounded,
                        value: shift.totalKm.toStringAsFixed(1),
                        unit: isRu ? 'км' : 'km',
                        label: isRu ? 'Расстояние' : 'Distance',
                        isDark: isDark,
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _StatBox(
                        icon: Icons.navigation_rounded,
                        value: '${shift.totalTrips}',
                        unit: isRu ? 'поездок' : 'trips',
                        label: isRu ? 'Поездки' : 'Trips',
                        isDark: isDark,
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _StatBox(
                        icon: Icons.timer_rounded,
                        value: _fmtDuration(shift.totalTime),
                        unit: '',
                        label: isRu ? 'Время в пути' : 'Drive time',
                        isDark: isDark,
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _StatBox(
                        icon: Icons.speed_rounded,
                        value: shift.avgSpeedKmh.toStringAsFixed(0),
                        unit: isRu ? 'км/ч' : 'km/h',
                        label: isRu ? 'Средняя скорость' : 'Avg speed',
                        isDark: isDark,
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Trip history
                  if (shift.trips.isNotEmpty) ...[
                    Text(
                      isRu ? 'История поездок' : 'Trip History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...shift.trips.reversed.map((t) => _TripTile(trip: t, isDark: isDark, isRu: isRu)),
                  ] else ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(Icons.local_taxi_rounded, size: 48,
                                color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext),
                            const SizedBox(height: 12),
                            Text(
                              isRu ? 'Нет поездок за смену' : 'No trips this shift',
                              style: TextStyle(
                                fontSize: 15,
                                color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    if (h > 0) return '$hч $mм';
    return '$m мин';
  }
}

class _ShiftCard extends StatelessWidget {
  final bool isDark;
  final bool isRu;
  final ShiftReportService shift;

  const _ShiftCard({required this.isDark, required this.isRu, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: shift.isOnShift
              ? [AppTheme.accent, AppTheme.accent.withValues(alpha: 0.8)]
              : [AppTheme.darkCard, AppTheme.darkCard],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (shift.isOnShift ? AppTheme.accent : Colors.black).withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: shift.isOnShift ? AppTheme.success : AppTheme.darkSubtext,
                  shape: BoxShape.circle,
                  boxShadow: shift.isOnShift
                      ? [BoxShadow(color: AppTheme.success.withValues(alpha: 0.5), blurRadius: 6)]
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                shift.isOnShift
                    ? (isRu ? 'Смена активна' : 'Shift active')
                    : (isRu ? 'Смена не начата' : 'Shift not started'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (shift.isOnShift)
                Text(
                  _fmtDuration(shift.shiftDuration),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                if (shift.isOnShift) {
                  shift.endShift();
                } else {
                  shift.startShift();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: shift.isOnShift
                      ? AppTheme.danger
                      : Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    shift.isOnShift
                        ? (isRu ? 'Завершить смену' : 'End shift')
                        : (isRu ? 'Начать смену' : 'Start shift'),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmtDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final sec = d.inSeconds % 60;
    if (h > 0) return '${h}ч ${m.toString().padLeft(2, '0')}м';
    return '${m}м ${sec.toString().padLeft(2, '0')}с';
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final bool isDark;

  const _StatBox({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppTheme.accent),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    unit,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
            ),
          ),
        ],
      ),
    );
  }
}

class _TripTile extends StatelessWidget {
  final TripRecord trip;
  final bool isDark;
  final bool isRu;

  const _TripTile({required this.trip, required this.isDark, required this.isRu});

  @override
  Widget build(BuildContext context) {
    final km = trip.distanceMeters / 1000;
    final dur = Duration(seconds: trip.durationSeconds);
    final time = '${dur.inHours > 0 ? '${dur.inHours}ч ' : ''}${dur.inMinutes % 60}м';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_taxi_rounded, size: 18, color: AppTheme.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${km.toStringAsFixed(1)} ${isRu ? "км" : "km"}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${trip.timestamp.hour.toString().padLeft(2, '0')}:${trip.timestamp.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext,
            ),
          ),
        ],
      ),
    );
  }
}
