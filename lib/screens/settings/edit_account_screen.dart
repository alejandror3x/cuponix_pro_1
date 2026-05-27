import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(
            title: 'Editar Cuenta',
            onBack: () => context.go('/configuracion'),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Nombre'),
                  const SizedBox(height: 5),
                  const PillTextField(hint: 'Tom'),
                  const SizedBox(height: 12),
                  _label('Usuario'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(
                    widthFactor: 0.72,
                    child: PillTextField(hint: '@tommyspace'),
                  ),
                  const SizedBox(height: 12),
                  _label('Correo Electrónico'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(
                    widthFactor: 0.72,
                    child: PillTextField(
                      hint: 'tom@cuponix.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _label('Número Telefónico'),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      SizedBox(
                        width: 78,
                        child: PillTextField(
                          hint: '+57',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: PillTextField(
                          hint: '300 000 0000',
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _label('Contraseña'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(
                    widthFactor: 0.72,
                    child: PillTextField(hint: 'Nueva contraseña', obscure: true),
                  ),
                  const SizedBox(height: 12),
                  _label('Repetir Contraseña'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(
                    widthFactor: 0.72,
                    child: PillTextField(hint: 'Confirmar contraseña', obscure: true),
                  ),
                  const SizedBox(height: 26),
                  Center(
                    child: PillButton(
                      label: 'GUARDAR',
                      onPressed: () => context.go('/configuracion'),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: GestureDetector(
                      onTap: () => _confirmDelete(context),
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.neonRed, width: 1.5),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'ELIMINAR CUENTA',
                          style: TextStyle(
                            color: AppColors.neonRed,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          letterSpacing: 0.13,
        ),
      );

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Eliminar cuenta', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Esta acción eliminará tu cuenta de Cuponix.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCELAR')),
          TextButton(onPressed: () => context.go('/login'), child: const Text('ELIMINAR')),
        ],
      ),
    );
  }
}
