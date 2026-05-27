import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CuponixHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CuponixHeader({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CuponixBackButton(onTap: onBack),
        const SizedBox(width: 20),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.13,
          ),
        ),
      ],
    );
  }
}

class CuponixBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;

  const CuponixBackButton({super.key, this.onTap, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: SizedBox(
        width: size,
        height: size,
        child: const CustomPaint(painter: _BackArrowPainter()),
      ),
    );
  }
}

class _BackArrowPainter extends CustomPainter {
  const _BackArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonRed
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width * 0.72, size.height * 0.15)
      ..lineTo(size.width * 0.22, size.height * 0.50)
      ..lineTo(size.width * 0.72, size.height * 0.85)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
