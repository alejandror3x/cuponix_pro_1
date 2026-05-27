import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/theme/app_colors.dart';

class CanjearPuntosScreen extends StatelessWidget {
  const CanjearPuntosScreen({super.key});

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
            CuponTitleRow(title: 'Canjear Puntos', onBack: () => context.go('/solicitudes')),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFFD4322B), fg: Colors.white, label: "Roger's", size: 90),
              name: "Roger's Smash",
              handle: '@rogersec',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [PointsIcon(size: 30), SizedBox(width: 6), Text('25', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600))],
              ),
            ),
            const CuponProductCard(name: 'Smash Bacon\nCebollitas'),
            const SizedBox(height: 16),
            const Text(
              '¿Deseas añadir un código a tu transacción?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, height: 1.25),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 300),
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                ),
                style: const TextStyle(color: AppColors.ink, fontSize: 14),
              ),
            ),
            const SizedBox(height: 14),
            CuponCta(label: 'CANJEAR', onPressed: () => context.go('/mostrar-qr')),
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
