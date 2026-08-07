import 'package:flutter/material.dart';
import '../l10n/strings.dart';
import '../services/routing_service.dart';
import '../theme/app_theme.dart';

class TurnBanner extends StatelessWidget {
  final TurnType turn;
  final double distanceMeters;
  final String streetName;
  final Strings strings;

  const TurnBanner({
    super.key,
    required this.turn,
    required this.distanceMeters,
    this.streetName = '',
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    if (turn == TurnType.arrive) return const SizedBox.shrink();

    final IconData arrowIcon;
    switch (turn) {
      case TurnType.turnRight:
        arrowIcon = Icons.turn_right_rounded;
        break;
      case TurnType.turnLeft:
        arrowIcon = Icons.turn_left_rounded;
        break;
      case TurnType.depart:
      case TurnType.straight:
      case TurnType.merge:
      case TurnType.roundabout:
      case TurnType.keep:
        arrowIcon = Icons.straight_rounded;
        break;
      case TurnType.arrive:
        arrowIcon = Icons.flag_rounded;
        break;
    }

    final String distText;
    if (distanceMeters >= 1000) {
      distText =
          '${(distanceMeters / 1000).toStringAsFixed(1)} ${strings.kilometers}';
    } else {
      distText = '${distanceMeters.round()} ${strings.meters}';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.accent,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(arrowIcon, color: Colors.white, size: 28),
              const SizedBox(width: 8),
              Text(
                distText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          if (streetName.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              streetName,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
