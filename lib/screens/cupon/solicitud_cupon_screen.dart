import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';

class SolicitudCuponScreen extends StatelessWidget {
  const SolicitudCuponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CuponScaffold(
      activeTab: NavTab.cupones,
      onNav: (t) => _nav(context, t),
      card: Padding(
        padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CuponTitleRow(title: 'Solicitud de Cupón', onBack: () => context.go('/solicitudes')),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFF5B6F8A), fg: Colors.white, label: 'A', size: 90),
              name: 'Alexis',
              handle: '@alexiscuponix',
            ),
            const CuponLead('¡Desea Usar tu Cupón!'),
            const CuponStatCentered(value: '20%', label: 'Descuento'),
            const CuponStatCentered(value: r'$15,00', label: 'Compra mínima'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  const Text('Recompenza:', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [PointsIcon(size: 30), SizedBox(width: 6), Text('15', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600))],
                  ),
                ],
              ),
            ),
            const CuponHelpText('Para confirmar, se abrirá tu lector\nde QR para el código del solicitante.'),
            const CuponExpiraText('12/12/25'),
            const Spacer(),
            CuponCta(label: 'CONFIRMAR', onPressed: () => _showCameraPopup(context)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showCameraPopup(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        content: const Text(
          '¿Autorizas a Cuponix a acceder a tu cámara?',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ahora no')),
          TextButton(onPressed: () => context.go('/lector-qr'), child: const Text('Aceptar')),
        ],
      ),
    );
  }

  void _nav(BuildContext context, NavTab t) {
    switch (t) {
      case NavTab.home: context.go('/home');
      case NavTab.explore: context.go('/explorar');
      case NavTab.cupones: context.go('/solicitudes');
      case NavTab.perfil: context.go('/perfil');
    }
  }
}
