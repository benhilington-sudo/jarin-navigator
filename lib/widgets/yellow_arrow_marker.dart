import 'dart:math';
import 'package:flutter/material.dart';

class YellowArrowMarker extends StatefulWidget {
  final double heading;
  final double size;

  const YellowArrowMarker({
    super.key,
    required this.heading,
    this.size = 52,
  });

  @override
  State<YellowArrowMarker> createState() => _YellowArrowMarkerState();
}

class _YellowArrowMarkerState extends State<YellowArrowMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 1.8,
      height: widget.size * 1.8,
      child: AnimatedBuilder(
        animation: _pulseCtrl,
        builder: (_, _) {
          final t = _pulseCtrl.value;
          final pulseR = widget.size * 0.45 + t * widget.size * 0.25;
          final pulseAlpha = (1.0 - t) * 0.25;
          return CustomPaint(
            painter: _ArrowPainter(
              heading: widget.heading,
              size: widget.size,
              pulseRadius: pulseR,
              pulseAlpha: pulseAlpha,
            ),
          );
        },
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final double heading;
  final double size;
  final double pulseRadius;
  final double pulseAlpha;

  _ArrowPainter({
    required this.heading,
    required this.size,
    required this.pulseRadius,
    required this.pulseAlpha,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final cx = canvasSize.width / 2;
    final cy = canvasSize.height / 2;
    final r = size * 0.32;

    // Pulse ring
    final pulsePaint = Paint()
      ..color = const Color(0xFF2979FF).withValues(alpha: pulseAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(Offset(cx, cy), pulseRadius, pulsePaint);

    // Outer glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF2979FF).withValues(alpha: 0.25),
          const Color(0xFF2979FF).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r * 2.2));
    canvas.drawCircle(Offset(cx, cy), r * 2.2, glowPaint);

    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(cx, cy + 4), r, shadowPaint);

    // White circle base
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFE8E8E8)],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)),
    );

    // Blue ring
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..color = const Color(0xFF2979FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Arrow
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(heading * pi / 180);

    final arrowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF2979FF), Color(0xFF1565C0)],
      ).createShader(Rect.fromLTWH(-r * 0.35, -r * 0.7, r * 0.7, r * 1.1))
      ..style = PaintingStyle.fill;

    final arrowPath = Path()
      ..moveTo(0, -r * 0.72)
      ..lineTo(r * 0.38, r * 0.25)
      ..quadraticBezierTo(r * 0.12, r * 0.10, 0, r * 0.18)
      ..quadraticBezierTo(-r * 0.12, r * 0.10, -r * 0.38, r * 0.25)
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter old) =>
      old.heading != heading ||
      old.pulseRadius != pulseRadius ||
      old.pulseAlpha != pulseAlpha;
}
