import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';

class MostrarQrScreen extends StatelessWidget {
  const MostrarQrScreen({super.key});

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
            const Text(
              'Muestra este código en:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, height: 1.1),
            ),
            const SizedBox(height: 14),
            CuponProfile(
              avatar: CuponAvatar(bg: const Color(0xFFD4322B), fg: Colors.white, label: "Roger's", size: 90),
              name: "Roger's Smash",
              handle: '@rogersec',
            ),
            const SizedBox(height: 14),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 20, offset: Offset(0, 8))],
              ),
              padding: const EdgeInsets.all(14),
              child: CustomPaint(painter: _FakeQrPainter()),
            ),
            const SizedBox(height: 14),
            const CuponHelpText('Para canjear tus Puntos por\nel Producto Selecionado.'),
            const Spacer(),
            CuponCta(label: 'ESCANEO COMPLETADO', onPressed: () => context.go('/gracias-visitar')),
            const SizedBox(height: 10),
            CuponCta(label: 'EN OTRO MOMENTO', onPressed: () => context.go('/solicitudes')),
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

class _FakeQrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final bk = Paint()..color = Colors.black..style = PaintingStyle.fill;
    final wh = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final u = s.width / 29;
    canvas.drawRect(Rect.fromLTWH(0, 0, s.width, s.height), wh);
    void finder(double ox, double oy) {
      canvas.drawRect(Rect.fromLTWH(ox * u, oy * u, 7 * u, 7 * u), bk);
      canvas.drawRect(Rect.fromLTWH((ox + 1) * u, (oy + 1) * u, 5 * u, 5 * u), wh);
      canvas.drawRect(Rect.fromLTWH((ox + 2) * u, (oy + 2) * u, 3 * u, 3 * u), bk);
    }
    finder(0, 0); finder(22, 0); finder(0, 22);
    void d(double x, double y, double w, double h) => canvas.drawRect(Rect.fromLTWH(x * u, y * u, w * u, h * u), bk);
    d(8, 0, 1, 1); d(10, 0, 2, 1); d(14, 0, 1, 2); d(17, 0, 2, 1); d(20, 0, 1, 1);
    d(8, 2, 2, 1); d(11, 2, 1, 2); d(13, 2, 2, 1); d(16, 2, 1, 3); d(19, 2, 2, 1);
    d(0, 8, 1, 2); d(2, 8, 3, 1); d(6, 8, 1, 2); d(9, 8, 2, 2); d(13, 8, 1, 1);
    d(15, 8, 2, 1); d(18, 8, 1, 3); d(20, 8, 2, 1); d(23, 8, 1, 2); d(25, 8, 2, 1); d(28, 8, 1, 2);
    d(1, 11, 2, 1); d(4, 11, 1, 2); d(7, 11, 2, 1); d(10, 11, 1, 2); d(12, 11, 2, 2);
    d(15, 11, 1, 1); d(17, 11, 3, 1); d(21, 11, 1, 2); d(24, 11, 2, 1); d(27, 11, 1, 2);
    d(0, 14, 2, 1); d(3, 14, 1, 2); d(5, 14, 2, 1); d(8, 14, 1, 2); d(10, 14, 3, 1);
    d(14, 14, 1, 3); d(16, 14, 2, 1); d(19, 14, 2, 2); d(22, 14, 1, 2); d(24, 14, 3, 1); d(28, 14, 1, 2);
    d(1, 17, 2, 2); d(4, 17, 3, 1); d(8, 17, 2, 1); d(11, 17, 1, 2); d(13, 17, 2, 2);
    d(16, 17, 1, 1); d(18, 17, 2, 1); d(21, 17, 2, 2); d(24, 17, 1, 3); d(26, 17, 2, 1);
    d(0, 20, 1, 2); d(3, 20, 2, 1); d(6, 20, 1, 2); d(8, 20, 3, 1); d(12, 20, 2, 1);
    d(15, 20, 1, 2); d(17, 20, 2, 1); d(20, 20, 1, 2); d(22, 20, 2, 1); d(26, 20, 1, 2); d(28, 20, 1, 1);
    d(8, 23, 1, 1); d(10, 23, 3, 1); d(14, 23, 1, 2); d(16, 23, 2, 1); d(19, 23, 2, 2);
    d(22, 23, 1, 3); d(24, 23, 2, 1); d(27, 23, 1, 2);
    d(8, 26, 2, 1); d(11, 26, 2, 2); d(14, 26, 1, 1); d(16, 26, 3, 1); d(20, 26, 1, 2);
    d(24, 26, 2, 1); d(28, 26, 1, 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
