import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              stops: [0.0, 0.18, 0.38, 0.58, 0.76, 0.88, 1.0],
              colors: [
                Color(0xFF2a1485),
                Color(0xFF3b1591),
                Color(0xFF6d1aa0),
                Color(0xFFa8189a),
                Color(0xFFd81672),
                Color(0xFFec1054),
                Color(0xFFff073a),
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final h = constraints.maxHeight;
                final w = constraints.maxWidth;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: h * 0.035,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Login block — left-aligned, ~55% width
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: w * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const PillTextField(
                                hint: 'Correo electrónico',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: h * 0.018),
                              const PillTextField(hint: 'Contraseña', obscure: true),
                              SizedBox(height: h * 0.018),
                              PillButton(label: 'INICIAR SESIÓN', onPressed: () => context.go('/home')),
                              SizedBox(height: h * 0.012),
                              GestureDetector(
                                onTap: () => context.push('/recover-email'),
                                child: const Text(
                                  '¿Necesitas ayuda?',
                                  style: TextStyle(
                                    color: AppColors.antique,
                                    fontSize: 15,
                                    letterSpacing: 0.15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Logo lockup
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/cuponix-imagotipo-cropped.png',
                              width: w * 0.28,
                            ),
                            SizedBox(height: h * 0.008),
                            Image.asset(
                              'assets/images/cuponix-logotipo-cropped.png',
                              width: w * 0.68,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // CTA 1: Registrate
                      const Text(
                        '¿Aún no tienes una cuenta?',
                        style: TextStyle(color: AppColors.antique, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: h * 0.014),
                      Center(
                        child: PillButton(
                          label: 'REGISTRATE',
                          variant: PillButtonVariant.secondary,
                          onPressed: () => context.push('/register'),
                        ),
                      ),
                      SizedBox(height: h * 0.014),
                      const Text(
                        'Comienza a disfrutar\nde grandes ofertas cerca tuyo\n¡Totalmente Gratis!',
                        style: TextStyle(
                          color: AppColors.antique,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: h * 0.022),

                      // CTA 2: Tour
                      const Text(
                        '¿Deseas saber cómo funciona?',
                        style: TextStyle(color: AppColors.antique, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: h * 0.014),
                      Center(
                        child: PillButton(
                          label: 'TOUR',
                          variant: PillButtonVariant.secondary,
                          onPressed: () => context.push('/tour'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
