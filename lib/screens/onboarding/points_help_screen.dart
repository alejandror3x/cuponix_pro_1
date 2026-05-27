import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/pill_button.dart';

class PointsHelpScreen extends StatelessWidget {
  const PointsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2444D8),
                Color(0xFF7A39B6),
                Color(0xFFD81672),
                AppColors.neonRed,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(34, 34, 34, 34),
              child: Column(
                children: [
                  const Spacer(),
                  const PointsIcon(size: 92),
                  const SizedBox(height: 24),
                  const Text(
                    'Puntos canjeables',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.antique,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'volver tiene\nsu recompenza',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Cada visita puede sumar puntos\npara canjear productos o servicios\nen ese mismo negocio.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      height: 1.32,
                    ),
                  ),
                  const Spacer(),
                  PillButton(
                    label: 'ENTENDIDO',
                    variant: PillButtonVariant.secondary,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
