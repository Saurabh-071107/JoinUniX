import 'package:flutter/material.dart';

/// Renders a crisp country flag for US, UK, Germany, and Canada (circular or rounded rectangle).
class CountryFlagCircle extends StatelessWidget {
  final String country;
  final double size;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const CountryFlagCircle({
    super.key,
    required this.country,
    this.size = 48,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final w = width ?? size;
    final h = height ?? size;
    final isCircle = borderRadius == null && width == null && height == null;

    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : (borderRadius ?? BorderRadius.circular(4)),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: isCircle ? BorderRadius.circular(size) : (borderRadius ?? BorderRadius.circular(4)),
        child: CustomPaint(
          size: Size(w, h),
          painter: _FlagPainter(country: country),
        ),
      ),
    );
  }
}

class _FlagPainter extends CustomPainter {
  final String country;

  _FlagPainter({required this.country});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final normalized = country.toLowerCase().trim();

    if (normalized.contains('united states') || normalized.contains('usa') || normalized == 'us') {
      _paintUsFlag(canvas, w, h);
    } else if (normalized.contains('united kingdom') || normalized.contains('uk') || normalized == 'gb') {
      _paintUkFlag(canvas, w, h);
    } else if (normalized.contains('germany') || normalized == 'de') {
      _paintGermanyFlag(canvas, w, h);
    } else if (normalized.contains('canada') || normalized == 'ca') {
      _paintCanadaFlag(canvas, w, h);
    } else {
      final p = Paint()..color = const Color(0xFF3B82F6);
      canvas.drawRect(Rect.fromLTWH(0, 0, w, h), p);
    }
  }

  void _paintUsFlag(Canvas canvas, double w, double h) {
    const stripes = 13;
    final stripeHeight = h / stripes;
    final red = Paint()..color = const Color(0xFFB22234);
    final white = Paint()..color = Colors.white;

    // 13 alternating stripes
    for (int i = 0; i < stripes; i++) {
      canvas.drawRect(
        Rect.fromLTWH(0, i * stripeHeight, w, stripeHeight),
        i.isEven ? red : white,
      );
    }

    // Official US canton: 7 stripes high, ~44% flag width
    final cantonW = w * 0.44;
    final cantonH = stripeHeight * 7;
    final cantonPaint = Paint()..color = const Color(0xFF3C3B6E);
    canvas.drawRect(Rect.fromLTWH(0, 0, cantonW, cantonH), cantonPaint);

    // Staggered constellation of stars
    final starPaint = Paint()..color = Colors.white;
    const rows = 5;
    final yStep = cantonH / (rows + 1);

    for (int r = 1; r <= rows; r++) {
      final isEvenRow = r.isEven;
      final cols = isEvenRow ? 5 : 6;
      final xStep = cantonW / (cols + 1);
      final rRadius = (cantonW * 0.024).clamp(0.7, 1.3);

      for (int c = 1; c <= cols; c++) {
        canvas.drawCircle(Offset(c * xStep, r * yStep), rRadius, starPaint);
      }
    }
  }

  void _paintUkFlag(Canvas canvas, double w, double h) {
    // Royal Navy background
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFF012169));

    // St. Andrew's white diagonal saltire
    final whiteDiagonal = Paint()
      ..color = Colors.white
      ..strokeWidth = h * 0.22
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(w, h), whiteDiagonal);
    canvas.drawLine(Offset(0, h), Offset(w, 0), whiteDiagonal);

    // St. Patrick's red diagonal saltire
    final redDiagonal = Paint()
      ..color = const Color(0xFFC8102E)
      ..strokeWidth = h * 0.09
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(w, h), redDiagonal);
    canvas.drawLine(Offset(0, h), Offset(w, 0), redDiagonal);

    // St. George's white cross backing
    final whiteCross = Paint()..color = Colors.white;
    final wcThickness = h * 0.28;
    canvas.drawRect(Rect.fromLTWH((w - wcThickness) / 2, 0, wcThickness, h), whiteCross);
    canvas.drawRect(Rect.fromLTWH(0, (h - wcThickness) / 2, w, wcThickness), whiteCross);

    // St. George's red cross
    final redCross = Paint()..color = const Color(0xFFC8102E);
    final rcThickness = h * 0.16;
    canvas.drawRect(Rect.fromLTWH((w - rcThickness) / 2, 0, rcThickness, h), redCross);
    canvas.drawRect(Rect.fromLTWH(0, (h - rcThickness) / 2, w, rcThickness), redCross);
  }

  void _paintGermanyFlag(Canvas canvas, double w, double h) {
    final stripeH = h / 3;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, stripeH), Paint()..color = const Color(0xFF111111));
    canvas.drawRect(Rect.fromLTWH(0, stripeH, w, stripeH), Paint()..color = const Color(0xFFDD0000));
    canvas.drawRect(Rect.fromLTWH(0, stripeH * 2, w, stripeH), Paint()..color = const Color(0xFFFFCC00));
  }

  void _paintCanadaFlag(Canvas canvas, double w, double h) {
    final red = Paint()..color = const Color(0xFFD80621);
    final white = Paint()..color = Colors.white;

    final sideW = w * 0.25;
    // Left red band
    canvas.drawRect(Rect.fromLTWH(0, 0, sideW, h), red);
    // Center white field (1:2:1 ratio)
    canvas.drawRect(Rect.fromLTWH(sideW, 0, w - 2 * sideW, h), white);
    // Right red band
    canvas.drawRect(Rect.fromLTWH(w - sideW, 0, sideW, h), red);

    // Stylized 11-point Canadian maple leaf
    final cx = w / 2;
    final cy = h / 2;
    final leafSize = h * 0.62;
    final path = Path();

    path.moveTo(cx, cy - leafSize * 0.50);
    path.lineTo(cx + leafSize * 0.10, cy - leafSize * 0.22);
    path.lineTo(cx + leafSize * 0.28, cy - leafSize * 0.24);
    path.lineTo(cx + leafSize * 0.22, cy - leafSize * 0.05);
    path.lineTo(cx + leafSize * 0.44, cy + leafSize * 0.06);
    path.lineTo(cx + leafSize * 0.28, cy + leafSize * 0.18);
    path.lineTo(cx + leafSize * 0.34, cy + leafSize * 0.30);
    path.lineTo(cx + leafSize * 0.12, cy + leafSize * 0.24);
    path.lineTo(cx + leafSize * 0.04, cy + leafSize * 0.38);
    path.lineTo(cx + leafSize * 0.04, cy + leafSize * 0.48);
    path.lineTo(cx - leafSize * 0.04, cy + leafSize * 0.48);
    path.lineTo(cx - leafSize * 0.04, cy + leafSize * 0.38);
    path.lineTo(cx - leafSize * 0.12, cy + leafSize * 0.24);
    path.lineTo(cx - leafSize * 0.34, cy + leafSize * 0.30);
    path.lineTo(cx - leafSize * 0.28, cy + leafSize * 0.18);
    path.lineTo(cx - leafSize * 0.44, cy + leafSize * 0.06);
    path.lineTo(cx - leafSize * 0.22, cy - leafSize * 0.05);
    path.lineTo(cx - leafSize * 0.28, cy - leafSize * 0.24);
    path.lineTo(cx - leafSize * 0.10, cy - leafSize * 0.22);
    path.close();

    canvas.drawPath(path, red);
  }

  @override
  bool shouldRepaint(covariant _FlagPainter oldDelegate) => oldDelegate.country != country;
}
