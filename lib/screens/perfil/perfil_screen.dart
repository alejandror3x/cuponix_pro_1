import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            // Header
            SafeArea(
              bottom: false,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Row(
                  children: [
                    BackTriangle(onTap: () => context.go('/home')),
                    const Expanded(
                      child: Text('@tommyspace', textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/mensajes'),
                      child: _iconBtn('assets/images/icon-mensajes.png'),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => context.go('/configuracion'),
                      child: _iconBtn('assets/images/icon-configuracion.png'),
                    ),
                  ],
                ),
              ),
            ),
            // Scrollable feed
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                children: [
                  // Avatar
                  Center(
                    child: Container(
                      width: 180, height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDB38B), shape: BoxShape.circle,
                        boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 18, offset: Offset(0, 6))],
                      ),
                      alignment: Alignment.center,
                      child: const Text('T', style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 48, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: Text('Tom', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 4),
                  // Stats row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: _statCell('1k', 'Seguidores', () => context.go('/seguidores'))),
                        Expanded(child: _statCell('1k', 'Seguidos', () => context.go('/seguidores'))),
                      ],
                    ),
                  ),
                  // Bio
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Fundador de MySpace.', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, height: 1.3)),
                  ),
                  // Interests
                  const SizedBox(height: 8),
                  const Center(
                    child: Text('Intereses:', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center, spacing: 10, runSpacing: 10,
                    children: ['software', 'pc', 'mac', 'social'].map(_tag).toList(),
                  ),
                  const SizedBox(height: 18),
                  // Perfil tabs (3-icon row)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(0.35))),
                    ),
                    child: Row(
                      children: [
                        _perfilTab('assets/images/tab-actividad-activado.png', true),
                        Container(width: 1, height: 60, color: Colors.white.withOpacity(0.35)),
                        _perfilTab('assets/images/tab-menu-desactivado.png', false),
                        Container(width: 1, height: 60, color: Colors.white.withOpacity(0.35)),
                        _perfilTab('assets/images/tab-valor-desactivado.png', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavBar(
              active: NavTab.perfil,
              onTap: (t) {
                switch (t) {
                  case NavTab.home: context.go('/home');
                  case NavTab.explore: break;
                  case NavTab.cupones: context.go('/cupones');
                  case NavTab.perfil: break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(String asset) => SizedBox(
    width: 36, height: 36,
    child: Image.asset(asset, fit: BoxFit.contain),
  );

  Widget _statCell(String value, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _tag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neonRed, width: 1.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
    );
  }

  Widget _perfilTab(String asset, bool active) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: Image.asset(asset, width: 54, height: 54, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
