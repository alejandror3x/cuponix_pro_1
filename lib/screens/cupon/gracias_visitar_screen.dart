import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';

class GraciasVisitarScreen extends StatelessWidget {
  const GraciasVisitarScreen({super.key});

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
            const Text(
              '¡Gracias por visitar!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700, height: 1.1),
            ),
            const SizedBox(height: 14),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFFD4322B), fg: Colors.white, label: "Roger's", size: 90),
              name: "Roger's Smash",
              handle: '@rogersec',
            ),
            const SizedBox(height: 14),
            const Text(
              'Resumen:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [PointsIcon(size: 30), SizedBox(width: 6), Text('x', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600))],
              ),
            ),
            const CuponProductCard(name: 'Smash Bacon\nCebollitas', showVerButton: false),
            const SizedBox(height: 14),
            const Text(
              '¡Esperamos que hayas disfrutado!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500, height: 1.25),
            ),
            const SizedBox(height: 16),
            CuponCta(label: 'ENTENDIDO', onPressed: () => context.go('/solicitudes')),
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
