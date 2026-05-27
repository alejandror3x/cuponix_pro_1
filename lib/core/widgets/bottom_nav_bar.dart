import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum NavTab { home, explore, cupones, perfil }

class BottomNavBar extends StatelessWidget {
  final NavTab active;
  final void Function(NavTab) onTap;

  const BottomNavBar({super.key, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              _btn(NavTab.home,    'nav-home'),
              _btn(NavTab.explore, 'nav-explorar'),
              _btn(NavTab.cupones, 'nav-cupones'),
              _btn(NavTab.perfil,  'nav-perfil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(NavTab tab, String key) {
    final on = active == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(tab),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Center(
            child: Image.asset(
              'assets/images/$key-${on ? 'activado' : 'desactivado'}.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
