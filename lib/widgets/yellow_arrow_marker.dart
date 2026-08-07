import 'package:flutter/material.dart';

class YellowArrowMarker extends StatelessWidget {
  final double heading;
  final double size;

  const YellowArrowMarker({
    super.key,
    required this.heading,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ArrowPainter(),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;
    final r = w * 0.38;

    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(Offset(cx, cy + 3), r, shadowPaint);

    // White circle
    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = Colors.white);

    // Grey border
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..color = const Color(0xFFBBBBBB)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Arrow pointing straight up
    final arrowPaint = Paint()
      ..color = const Color(0xFF444444)
      ..style = PaintingStyle.fill;

    final arrowPath = Path()
      ..moveTo(cx, cy - r * 0.75)
      ..lineTo(cx + r * 0.40, cy + r * 0.35)
      ..lineTo(cx, cy + r * 0.10)
      ..lineTo(cx - r * 0.40, cy + r * 0.35)
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
