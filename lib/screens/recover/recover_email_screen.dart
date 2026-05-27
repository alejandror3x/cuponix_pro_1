import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class RecoverEmailScreen extends StatelessWidget {
  const RecoverEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CuponixBackButton(onTap: () => context.pop()),
          const SizedBox(height: 60),

          const Text(
            '¿Olvidaste tus datos?\n¡No hay problema!\nEnviaremos a tu correo un\nenlace de recuperación.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          Center(
            child: SizedBox(
              width: 220,
              child: PillTextField(keyboardType: TextInputType.emailAddress),
            ),
          ),
          const SizedBox(height: 14),

          Center(
            child: PillButton(
              label: 'ENVIAR',
              onPressed: () => context.push('/recover-sent'),
            ),
          ),

          const Spacer(),

          const Text(
            '¿No recuerdas tu correo?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),

          Center(
            child: PillButton(
              label: 'PROBAR OTRA FORMA',
              onPressed: () => context.push('/recover-user'),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
