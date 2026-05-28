import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/pill_button.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CuponScaffold(
      activeTab: NavTab.perfil,
      onNav: (t) {
        switch (t) {
          case NavTab.home:
            context.go('/home');
          case NavTab.explore:
            context.go('/explorar');
          case NavTab.cupones:
            context.go('/solicitudes');
          case NavTab.perfil:
            context.go('/negocio');
        }
      },
      card: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
        child: Column(
          children: [
            CuponTitleRow(title: 'Producto', onBack: () => context.go('/negocio?tab=menu')),
            const SizedBox(height: 8),
            Container(
              height: 210,
              decoration: BoxDecoration(
                color: AppColors.avatarGrey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 18, offset: Offset(0, 8))],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.fastfood, color: Colors.white70, size: 72),
            ),
            const SizedBox(height: 16),
            const Text(
              'Smash Bacon',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Burger smash con bacon, queso, cebollitas y salsa de la casa.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, height: 1.3),
            ),
            const SizedBox(height: 18),
            const Text(
              r'$8.99',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PointsIcon(size: 28),
                SizedBox(width: 6),
                Text('25', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 22),
            PillButton(label: 'CANJEAR', onPressed: () => context.go('/canjear-puntos')),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go('/negocio?tab=valoraciones'),
              child: const Text('VER VALORACIONES'),
            ),
          ],
        ),
      ),
    );
  }
}
