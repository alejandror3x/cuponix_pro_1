import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool _privateAccount = false;

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(title: 'Editar Cuenta', onBack: () => context.go('/configuracion')),
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
                  const FractionallySizedBox(widthFactor: 0.72, child: PillTextField(hint: '@tommyspace')),
                  const SizedBox(height: 12),
                  _label('Correo Electrónico'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(widthFactor: 0.72, child: PillTextField(hint: 'tom@cuponix.com', keyboardType: TextInputType.emailAddress)),
                  const SizedBox(height: 12),
                  _label('Número Telefónico'),
                  const SizedBox(height: 5),
                  const Row(children: [
                    SizedBox(width: 78, child: PillTextField(hint: '+57', keyboardType: TextInputType.number)),
                    SizedBox(width: 10),
                    Expanded(child: PillTextField(hint: '300 000 0000', keyboardType: TextInputType.phone)),
                  ]),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Text('Cuenta Privada', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      CuponixToggle(value: _privateAccount, onChanged: (v) => setState(() => _privateAccount = v)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _label('Nueva Contraseña'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(widthFactor: 0.72, child: PillTextField(hint: 'Nueva contraseña', obscure: true)),
                  const SizedBox(height: 12),
                  _label('Repetir Nueva Contraseña'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(widthFactor: 0.72, child: PillTextField(hint: 'Confirmar contraseña', obscure: true)),
                  const SizedBox(height: 26),
                  Center(child: PillButton(label: 'GUARDAR', onPressed: () => context.go('/configuracion'))),
                  const SizedBox(height: 18),
                  Center(
                    child: GestureDetector(
                      onTap: () => _confirmDelete(context),
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.neonRed, width: 1.5), borderRadius: BorderRadius.circular(999)),
                        alignment: Alignment.center,
                        child: const Text('ELIMINAR CUENTA', style: TextStyle(color: AppColors.neonRed, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1)),
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

  Widget _label(String text) => Text(text, style: const TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 0.13));

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        content: const Text('Al aceptar se eliminarán\ntodos tus datos. Continuar?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, height: 1.3)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () => context.go('/login'), child: const Text('Aceptar')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ahora no')),
        ],
      ),
    );
  }
}
