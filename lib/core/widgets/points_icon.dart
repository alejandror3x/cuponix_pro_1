import 'package:flutter/material.dart';

class PointsIcon extends StatelessWidget {
  final double size;
  final Color color;

  const PointsIcon({super.key, this.size = 20, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PointsPainter(color: color),
    );
  }
}

class _PointsPainter extends CustomPainter {
  final Color color;
  const _PointsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size s) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s.width * 0.09;
    final fill = Paint()..color = color..style = PaintingStyle.fill;

    // Circle
    canvas.drawCircle(Offset(s.width / 2, s.height / 2), s.width * 0.375, stroke);

    // 5-pointed star
    final cx = s.width / 2;
    final cy = s.height / 2;
    final path = Path();
    const points = [
      [0.5, 0.33],  // top
      [0.56, 0.46], [0.69, 0.46], // top-right
      [0.58, 0.54], [0.625, 0.67], // right
      [0.5, 0.60], [0.375, 0.67], // left
      [0.42, 0.54], [0.31, 0.46], // top-left
      [0.44, 0.46],
    ];
    for (var i = 0; i < points.length; i++) {
      final x = points[i][0] * s.width;
      final y = points[i][1] * s.height;
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
