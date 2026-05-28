import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  bool _efectivo = false;
  bool _tarjeta = false;
  bool _transferencia = false;
  bool _calificaciones = true;

  void _askLocation() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text('Cuponix desea acceder a tu\nubicación al usar la App', textAlign: TextAlign.center, style: TextStyle(color: AppColors.ink, fontSize: 16)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () { Navigator.of(context).pop(); context.push('/map-business-setup'); }, child: const Text('Permitir')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ahora no')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(title: 'Perfil de Negocio', onBack: () => context.pop()),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Omite este paso si deseas usar\nCuponix como cliente y no como negocio.', style: TextStyle(color: Colors.white, fontSize: 15, height: 1.3)),
                  const SizedBox(height: 10),
                  _optLabel('Tipo de Negocio'),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(widthFactor: 0.65, child: PillTextField()),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_optLabel('Dirección'), const SizedBox(height: 5), const PillTextField()])),
                      const SizedBox(width: 12),
                      PillButton(label: 'UBICAR EN MAPA', variant: PillButtonVariant.small, onPressed: _askLocation),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: const TextSpan(text: 'Aceptas pagos en:  ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500), children: [TextSpan(text: '(Opcional)', style: TextStyle(color: Color(0xBFFFFFFF), fontSize: 12, fontWeight: FontWeight.w400))]),
                  ),
                  const SizedBox(height: 6),
                  Row(children: [
                    Expanded(child: _payOption('Efectivo', _efectivo, (v) => setState(() => _efectivo = v))),
                    Expanded(child: _payOption('Tarjeta', _tarjeta, (v) => setState(() => _tarjeta = v))),
                    Expanded(child: _payOption('Transferencia', _transferencia, (v) => setState(() => _transferencia = v))),
                  ]),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    RichText(text: const TextSpan(text: 'Permitir Calificaciones\ny comentarios.  ', style: TextStyle(color: Colors.white, fontSize: 15, height: 1.25), children: [TextSpan(text: '(Opcional)', style: TextStyle(color: Color(0xBFFFFFFF), fontSize: 12))])),
                    CuponixToggle(value: _calificaciones, onChanged: (v) => setState(() => _calificaciones = v)),
                  ]),
                  const SizedBox(height: 10),
                  const Align(alignment: Alignment.centerRight, child: Text('Productos /Servicios', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))),
                  const SizedBox(height: 6),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 200 / 240),
                    itemCount: 3,
                    itemBuilder: (_, _) => GestureDetector(
                      onTap: () => context.push('/product-create'),
                      child: Container(decoration: BoxDecoration(color: AppColors.avatarGrey, borderRadius: BorderRadius.circular(14), boxShadow: const [BoxShadow(color: Color(0x4D000000), blurRadius: 14, offset: Offset(0, 6))]), child: const Icon(Icons.add, color: Color(0x8CFFFFFF), size: 28)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Center(child: PillButton(label: 'REGISTRAR', onPressed: () => context.go('/email-verification'))),
                  const SizedBox(height: 14),
                  Center(child: GestureDetector(onTap: () => context.go('/email-verification'), child: const Text('OMITIR Y USAR COMO CLIENTE', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1)))),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optLabel(String text) => RichText(text: TextSpan(text: '$text  ', style: const TextStyle(color: Colors.white, fontSize: 13), children: const [TextSpan(text: '(Opcional)', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11))]));

  Widget _payOption(String name, bool value, ValueChanged<bool> onChange) => GestureDetector(
    onTap: () => onChange(!value),
    child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Column(children: [CuponixToggle(value: value, onChanged: onChange, size: 28), const SizedBox(height: 10), Text(name, style: const TextStyle(color: Colors.white, fontSize: 14))])),
  );
}
