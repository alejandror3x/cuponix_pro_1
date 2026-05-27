import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/dark_scaffold.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
      child: Column(
        children: [
          Row(
            children: [
              BackTriangle(onTap: () => context.go('/configuracion')),
              const Expanded(
                child: Text(
                  'Términos',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xE0555555),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const SingleChildScrollView(
                child: Text(
                  'Al usar Cuponix aceptas que los cupones, puntos, solicitudes y mensajes dependen de la disponibilidad de cada negocio.\n\n'
                  'Los puntos se acumulan por negocio y solo pueden canjearse en el local que los emitió. Las promociones pueden tener fecha de expiración, condiciones de compra mínima y validación por código QR.\n\n'
                  'Cuponix puede solicitar permisos de ubicación, notificaciones y cámara para habilitar búsqueda cercana, avisos y validación de cupones.\n\n'
                  'Esta pantalla es una versión visual inicial de términos y condiciones.',
                  style: TextStyle(color: Colors.white, fontSize: 17, height: 1.35),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
