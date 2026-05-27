import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';

class GraciasCuponScreen extends StatelessWidget {
  const GraciasCuponScreen({super.key});

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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _StatCol(value: '20%', label: 'Descuento'),
                SizedBox(width: 20),
                _StatCol(value: r'$15,00', label: 'Compra mínima'),
                SizedBox(width: 20),
                _PointsCol(pts: '15', label: 'Recompenza'),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Disfruta canjeando tus puntos\npor más productos o servicios\nen este mismo negocio.\n¡Esperamos que vuelvas pronto!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, height: 1.35),
            ),
            const SizedBox(height: 20),
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
      case NavTab.explore: context.go('/explorar');
      case NavTab.cupones: context.go('/solicitudes');
      case NavTab.perfil: context.go('/perfil');
    }
  }
}

class _StatCol extends StatelessWidget {
  final String value;
  final String label;
  const _StatCol({required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ],
  );
}

class _PointsCol extends StatelessWidget {
  final String pts;
  final String label;
  const _PointsCol({required this.pts, required this.label});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        const PointsIcon(size: 22),
        const SizedBox(width: 4),
        Text(pts, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
      ]),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ],
  );
}
