import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/points_icon.dart';

class HistorialDetailScreen extends StatelessWidget {
  const HistorialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CuponScaffold(
      activeTab: NavTab.cupones,
      onNav: (t) {
        switch (t) {
          case NavTab.home:
            context.go('/home');
          case NavTab.explore:
            context.go('/explorar');
          case NavTab.cupones:
            context.go('/historial');
          case NavTab.perfil:
            context.go('/perfil');
        }
      },
      card: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
        child: Column(
          children: [
            CuponTitleRow(title: 'Detalle', onBack: () => context.go('/historial')),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFF5B6F8A), fg: Colors.white, label: 'A', size: 90),
              name: 'Alexis',
              handle: '@alexiscuponix',
            ),
            const SizedBox(height: 12),
            const CuponLead('Usó un Cupón'),
            const CuponStatCentered(value: '20%', label: 'Descuento'),
            const CuponStatCentered(value: r'$15,00', label: 'Compra mínima'),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PointsIcon(size: 28),
                SizedBox(width: 6),
                Text('15', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600)),
              ],
            ),
            const Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 20),
            const Text(
              'Fecha: 14/04/25\nHora: 16:20\nNegocio: Roger\'s Smash\nCódigo: CPNX-2045',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
