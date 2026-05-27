import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CuponixBackButton(onTap: () => context.pop()),
          ),
          const SizedBox(height: 60),

          const Text(
            '¡Casi listo!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          const Text(
            'Por favor ingresa a tu buzón de,\nSMS, hemos enviado un código\nde recuperación.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),

          Center(
            child: SizedBox(
              width: 220,
              child: PillTextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                letterSpacing: 6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: PillButton(
              label: 'INGRESAR',
              onPressed: () => context.go('/home'),
            ),
          ),

          const Spacer(),

          Center(
            child: PillButton(
              label: 'INICIO',
              onPressed: () => context.go('/login'),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
