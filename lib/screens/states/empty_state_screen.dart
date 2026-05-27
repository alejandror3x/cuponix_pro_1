import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class EmptyStateScreen extends StatelessWidget {
  final String title;
  final String body;
  final String action;
  final String route;
  final NavTab activeTab;

  const EmptyStateScreen({
    super.key,
    required this.title,
    required this.body,
    required this.action,
    required this.route,
    this.activeTab = NavTab.home,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              color: AppColors.black,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  BackTriangle(onTap: () => context.pop()),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondo-negro.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(34, 40, 34, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 86),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.3),
                    ),
                    const SizedBox(height: 28),
                    PillButton(label: action, onPressed: () => context.go(route)),
                  ],
                ),
              ),
            ),
          ),
          BottomNavBar(
            active: activeTab,
            onTap: (t) {
              switch (t) {
                case NavTab.home:
                  context.go('/home');
                case NavTab.explore:
                  context.go('/explorar');
                case NavTab.cupones:
                  context.go('/cupones');
                case NavTab.perfil:
                  context.go('/perfil');
              }
            },
          ),
        ],
      ),
    );
  }
}
