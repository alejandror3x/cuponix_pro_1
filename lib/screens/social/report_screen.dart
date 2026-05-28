import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final Set<String> _selected = {};

  static const _reasons = [
    'Me resulta falsa.',
    'Sube contenido inapropiado.',
    'Me está acosando.',
    'Se hace pasar por otra cuenta.',
    'No cumple con sus promociones.',
    'No sigue activo.',
  ];

  void _send() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Gracias por informarnos,', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        content: const Text('Revisaremos en breve.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 17)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () => context.go('/negocio'), child: const Text('ENTENDIDO')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    BackTriangle(onTap: () => context.go('/negocio')),
                    const Expanded(child: Text('Reportar', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700))),
                    const SizedBox(width: 40),
                  ]),
                  const SizedBox(height: 22),
                  const Text(
                    'Cada reporte ayuda a proteger\nla confianza y seguridad de la comunidad.\n\nTrabajemos para que CUPONIX\nsea un espacio seguro para todos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, height: 1.35, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  const Text('Esta cuenta...', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _reasons.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final reason = _reasons[i];
                        final on = _selected.contains(reason);
                        return GestureDetector(
                          onTap: () => setState(() => on ? _selected.remove(reason) : _selected.add(reason)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(color: const Color(0xE0555555), borderRadius: BorderRadius.circular(18)),
                            child: Row(children: [
                              Expanded(child: Text(reason, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500))),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: on ? AppColors.neonRed : Colors.white, border: Border.all(color: Colors.white, width: 2)),
                                child: on ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
                              ),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(child: PillButton(label: 'ENVIAR', onPressed: _send)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
