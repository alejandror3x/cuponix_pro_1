import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class RecoverSentScreen extends StatelessWidget {
  const RecoverSentScreen({super.key});

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
          const Spacer(),
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
            'Por favor ingresa a tu correo,\nhemos enviado un enlace\nde recuperación.',
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
              label: 'VOLVER A ENVIAR',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enlace reenviado')),
                );
              },
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
