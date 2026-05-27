import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pill_button.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

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
                  Image.asset(
                    'assets/images/cuponix-imagotipo-cropped.png',
                    width: 118,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'donde vayas...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.antique,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      height: 1.05,
                    ),
                  ),
                  const Text(
                    'ganas!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.antique,
                      fontSize: 58,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Encuentra descuentos cerca tuyo,\nguarda cupones y acumula puntos\ncada vez que vuelves a tus lugares favoritos.',
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
                    label: 'REGISTRATE',
                    variant: PillButtonVariant.secondary,
                    onPressed: () => context.go('/register'),
                  ),
                  const SizedBox(height: 16),
                  PillButton(
                    label: 'INICIO',
                    variant: PillButtonVariant.secondary,
                    onPressed: () => context.go('/login'),
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
