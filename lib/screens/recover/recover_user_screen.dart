import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class RecoverUserScreen extends StatelessWidget {
  const RecoverUserScreen({super.key});

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
          const SizedBox(height: 52),

          const Text(
            'Por favor, ingresa tu\nnombre de Usuario.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Center(
            child: SizedBox(
              width: 220,
              child: PillTextField(),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Ingresa tu número de\nteléfono, enviaremos\nun SMS con un código\nde recuperación.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 80,
                  child: PillTextField(
                    hint: '+57',
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 200,
                  child: PillTextField(
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Center(
            child: PillButton(
              label: 'ENVIAR',
              onPressed: () => context.push('/verify-code'),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
