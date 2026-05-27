import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class BusinessMapScreen extends StatelessWidget {
  const BusinessMapScreen({super.key});

  static final Uri _mapsUri = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=Av.%20Principal%20y%20Calle%2010',
  );

  Future<void> _openGoogleMaps() async {
    await launchUrl(_mapsUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D4D4),
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _MapPainter()),
            ),
            Positioned(
              left: 24,
              right: 24,
              top: 130,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFD4322B),
                      child: Text(
                        'R',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Roger's Smash",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Av. Principal y Calle 10',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x59000000),
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                  child: Row(
                    children: [
                      BackTriangle(onTap: () => context.go('/negocio')),
                      const Expanded(
                        child: Text(
                          'Ubicación',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 34,
              right: 34,
              bottom: 34,
              child: SafeArea(
                top: false,
                child: PillButton(
                  label: 'IR A GOOGLE MAPS',
                  onPressed: _openGoogleMaps,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFD4D4D4);
    canvas.drawRect(Offset.zero & size, bg);

    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final road2 = Paint()
      ..color = const Color(0xFFC2C2C2)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(-20, size.height * 0.32)
      ..quadraticBezierTo(
        size.width * 0.34,
        size.height * 0.24,
        size.width + 30,
        size.height * 0.38,
      );

    canvas.drawPath(path, road);
    canvas.drawPath(path, road2);

    final path2 = Path()
      ..moveTo(size.width * 0.18, -20)
      ..quadraticBezierTo(
        size.width * 0.38,
        size.height * 0.42,
        size.width * 0.48,
        size.height + 20,
      );

    canvas.drawPath(path2, road);
    canvas.drawPath(path2, road2);

    final pin = Paint()..color = AppColors.neonRed;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 16, pin);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      7,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
