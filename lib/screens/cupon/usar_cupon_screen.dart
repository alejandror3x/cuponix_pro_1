import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';

class UsarCuponScreen extends StatefulWidget {
  const UsarCuponScreen({super.key});

  @override
  State<UsarCuponScreen> createState() => _UsarCuponScreenState();
}

class _UsarCuponScreenState extends State<UsarCuponScreen> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CuponScaffold(
      activeTab: NavTab.explore,
      onNav: (t) => _nav(context, t),
      card: Padding(
        padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CuponTitleRow(title: 'Usar Cupón', onBack: () => context.go('/buscar-resultados')),
            const SizedBox(height: 10),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFFD4322B), fg: Colors.white, label: "Roger's", size: 90),
              name: "Roger's Smash",
              handle: '@rogersec',
            ),
            const SizedBox(height: 14),
            const _StatRow(value: '20%', label: 'Descuento'),
            const _StatRow(value: r'$15,00', label: 'Compra mínima'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Recompenza: ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                  const PointsIcon(size: 22),
                  const SizedBox(width: 5),
                  const Text('5', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const CuponHelpText('¡Podrás canjear estos puntos por\nmás productos de este negocio!'),
            const Spacer(),
            const Text(
              '¿Deseas añadir un código al cupón?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, height: 1.3),
            ),
            const SizedBox(height: 14),
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _codeController,
                style: const TextStyle(color: Color(0xFF1C1C1C), fontSize: 16),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(height: 14),
            CuponCta(label: 'USAR', onPressed: () => context.go('/mostrar-codigo')),
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
      case NavTab.cupones: context.go('/cupones');
      case NavTab.perfil: context.go('/perfil');
    }
  }
}

class _StatRow extends StatelessWidget {
  final String value;
  final String label;
  const _StatRow({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600)),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}
