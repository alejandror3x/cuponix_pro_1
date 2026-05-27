import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/cuponix-imagotipo-cropped.png',
            width: 96,
            height: 96,
          ),
          const SizedBox(height: 26),
          const Text(
            '¡Casi listo!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Por favor ingresa a tu correo,\nhemos enviado un enlace\nde verificación.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
          const Spacer(),
          Center(
            child: PillButton(
              label: 'YA VERIFIQUÉ MI CORREO',
              onPressed: () => context.go('/suggested-accounts'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: PillButton(
              label: 'INICIO',
              onPressed: () => context.go('/login'),
            ),
          ),
        ],
      ),
    );
  }
}
