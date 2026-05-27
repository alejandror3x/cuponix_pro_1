import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/theme/app_colors.dart';

class CuponListoScreen extends StatefulWidget {
  const CuponListoScreen({super.key});

  @override
  State<CuponListoScreen> createState() => _CuponListoScreenState();
}

class _CuponListoScreenState extends State<CuponListoScreen> {
  bool _isConsumo = true;

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
            const Text(
              '¡Cupón Listo!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700, height: 1.1),
            ),
            const SizedBox(height: 10),
            // Variant toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _variantBtn('Consumo', _isConsumo, () => setState(() => _isConsumo = true)),
                const SizedBox(width: 4),
                _variantBtn('Personalizado', !_isConsumo, () => setState(() => _isConsumo = false)),
              ],
            ),
            const SizedBox(height: 10),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFFD4322B), fg: Colors.white, label: "Roger's", size: 90),
              name: "Roger's Smash",
              handle: '@rogersec',
            ),
            const SizedBox(height: 10),
            const Text(
              'Resumen:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (_isConsumo) ...[
              const CuponStatCentered(value: '20%', label: 'Descuento'),
              const CuponStatCentered(value: r'$15,00', label: 'Compra mínima'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [PointsIcon(size: 30), SizedBox(width: 6), Text('15', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600))],
                ),
              ),
              const Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: 14)),
            ] else ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'Por la compra de 2 Big Baby, la tercera a\nmitad de precio.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500, height: 1.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [PointsIcon(size: 30), SizedBox(width: 6), Text('5', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600))],
                ),
              ),
              const Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
            const SizedBox(height: 14),
            const Text('Creación: 14:35  01/12/25', style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Expiración: 31/12/25', style: TextStyle(color: Colors.white, fontSize: 16)),
            const Spacer(),
            CuponCta(label: 'ENTENDIDO', onPressed: () => context.go('/cupones')),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _variantBtn(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: active ? AppColors.neonRed : Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
      ),
    );
  }

  void _nav(BuildContext context, NavTab t) {
    switch (t) {
      case NavTab.home: context.go('/home');
      case NavTab.explore: break;
      case NavTab.cupones: context.go('/cupones');
      case NavTab.perfil: context.go('/perfil');
    }
  }
}
