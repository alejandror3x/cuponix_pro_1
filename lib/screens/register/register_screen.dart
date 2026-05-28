import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPrivate = false;
  bool _acceptTerms = true;

  void _next() {
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar términos y condiciones para continuar.')),
      );
      return;
    }
    context.push('/edit-profile');
  }

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(title: 'Registrar Cuenta', onBack: () => context.pop()),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('Nombre'),
                            const SizedBox(height: 4),
                            const PillTextField(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Cuenta Privada',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(width: 12),
                            CuponixToggle(
                              value: _isPrivate,
                              onChanged: (v) => setState(() => _isPrivate = v),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  _fieldLabel('Usuario'),
                  const SizedBox(height: 4),
                  const FractionallySizedBox(
                    widthFactor: 0.65,
                    child: PillTextField(),
                  ),
                  const SizedBox(height: 10),

                  _fieldLabel('Correo Electrónico'),
                  const SizedBox(height: 4),
                  const FractionallySizedBox(
                    widthFactor: 0.65,
                    child: PillTextField(keyboardType: TextInputType.emailAddress),
                  ),
                  const SizedBox(height: 10),

                  _fieldLabel('Contraseña'),
                  const SizedBox(height: 4),
                  const FractionallySizedBox(
                    widthFactor: 0.65,
                    child: PillTextField(obscure: true),
                  ),
                  const SizedBox(height: 10),

                  _fieldLabel('Repetir Contraseña'),
                  const SizedBox(height: 4),
                  const FractionallySizedBox(
                    widthFactor: 0.65,
                    child: PillTextField(obscure: true),
                  ),
                  const SizedBox(height: 10),

                  _fieldLabel('Número Telefónico'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: PillTextField(
                          hint: '+57',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: PillTextField(keyboardType: TextInputType.phone),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () => context.push('/terminos'),
                      child: const Text(
                        'Terminos y Condiciones.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CuponixToggle(
                          value: _acceptTerms,
                          onChanged: (v) => setState(() => _acceptTerms = v),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Aceptar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: PillButton(
                      label: 'SIGUIENTE',
                      onPressed: _next,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) => Text(
    text,
    style: const TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 0.13),
  );
}
