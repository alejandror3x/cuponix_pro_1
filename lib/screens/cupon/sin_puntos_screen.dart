import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';

class SinPuntosScreen extends StatelessWidget {
  const SinPuntosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CuponScaffold(
      activeTab: NavTab.cupones,
      onNav: (t) => _nav(context, t),
      card: Padding(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              '¡Lo Sentimos!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700, height: 1.1),
            ),
            const SizedBox(height: 22),
            const Text(
              'Parece que no tienes Puntos suficientes.\nUsa ó Comparte Cupónes para obtener\nmás Puntos.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500, height: 1.35),
            ),
            const Spacer(),
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
