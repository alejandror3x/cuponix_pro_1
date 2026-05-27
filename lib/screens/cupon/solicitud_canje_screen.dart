import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';

class SolicitudCanjeScreen extends StatelessWidget {
  const SolicitudCanjeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CuponScaffold(
      activeTab: NavTab.cupones,
      onNav: (t) => _nav(context, t),
      card: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CuponTitleRow(title: 'Solicitud de Canje', onBack: () => context.go('/solicitudes')),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFFCDB38B), label: 'T', size: 90),
              name: 'Tom',
              handle: '@tommyspace',
            ),
            const CuponLead('¡Desea Canjear sus puntos en tu producto!'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [PointsIcon(size: 30), SizedBox(width: 6), Text('25', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600))],
              ),
            ),
            const CuponProductCard(name: 'Smash Bacon\nCebollitas'),
            const CuponHelpText('Para confirmar, se abrirá tu lector\nde QR para el código del solicitante.'),
            const SizedBox(height: 16),
            CuponCta(label: 'CONFIRMAR', onPressed: () => context.go('/lector-qr')),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _nav(BuildContext context, NavTab t) {
    switch (t) {
      case NavTab.home: context.go('/home');
      case NavTab.explore: break;
      case NavTab.cupones: context.go('/solicitudes');
      case NavTab.perfil: context.go('/perfil');
    }
  }
}
