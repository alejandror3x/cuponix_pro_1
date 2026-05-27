import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF111111), Color(0xFF2D1078), Color(0xFF111111)],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        BackTriangle(onTap: () => context.go('/solicitudes')),
                        const Expanded(
                          child: Text(
                            'Escanear QR',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.neonRed, width: 4),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: CustomPaint(painter: _ScannerPainter()),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Alinea el código QR dentro del recuadro\npara confirmar la solicitud.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17, height: 1.3),
                    ),
                    const Spacer(),
                    PillButton(label: 'SIMULAR ESCANEO', onPressed: () => context.go('/historial-detalle')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 2;
    for (var i = 1; i < 4; i++) {
      final p = size.width * i / 4;
      canvas.drawLine(Offset(p, 0), Offset(p, size.height), paint);
      canvas.drawLine(Offset(0, p), Offset(size.width, p), paint);
    }
    final beam = Paint()
      ..color = AppColors.neonRed.withValues(alpha: 0.85)
      ..strokeWidth = 3;
    canvas.drawLine(Offset(18, size.height * 0.5), Offset(size.width - 18, size.height * 0.5), beam);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
