import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
                  'Ayuda',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 24),
          _item('¿Cómo uso un cupón?', 'Elige un cupón, toca USAR y muestra el código QR en el negocio.'),
          _item('¿Cómo canjeo puntos?', 'Entra al menú de un negocio y toca CANJEAR en un producto disponible.'),
          _item('¿Dónde veo mis solicitudes?', 'En el tab de cupones puedes revisar recibidas, enviadas e historial.'),
          const Spacer(),
          PillButton(label: 'CONTACTAR SOPORTE', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _item(String title, String body) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: const Color(0xE0555555),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(body, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.25)),
          ],
        ),
      );
}
