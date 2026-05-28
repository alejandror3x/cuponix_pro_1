import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';

class MostrarCodigoScreen extends StatelessWidget {
  const MostrarCodigoScreen({super.key});

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
            const Text('Muestra este código en:', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, height: 1.1)),
            const SizedBox(height: 12),
            CuponProfile(avatar: CuponAvatar(bg: const Color(0xFFD4322B), fg: Colors.white, label: "Roger's", size: 80), name: "Roger's Smash", handle: '@rogersec'),
            const SizedBox(height: 14),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 20, offset: Offset(0, 8))]),
              padding: const EdgeInsets.all(14),
              child: CustomPaint(painter: _QrPainter()),
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: const [
              _McStat(value: '20%', label: 'Descuento'),
              _McStat(value: r'$15,00', label: 'Compra mínima'),
              _McStatPoints(points: '5', label: 'Recompenza'),
            ]),
            const SizedBox(height: 10),
            const Text('Expira: 12/12/25', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 13)),
            const Spacer(),
            CuponCta(label: 'ESCANEO COMPLETADO', onPressed: () => context.go('/gracias-cupon')),
            const SizedBox(height: 10),
            CuponCta(label: 'EN OTRO MOMENTO', onPressed: () => _askSave(context)),
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

  void _goToMisCupones(BuildContext context, {required bool saved}) {
    Navigator.of(context).pop();
    if (saved) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cupón guardado')));
    }
    context.go('/cupones');
  }

  void _askSave(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        title: const Text('Guardar Cupón', style: TextStyle(color: Colors.white)),
        content: const Text('¿Deseas Guardar este Cupón\npara otro momento?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () => _goToMisCupones(context, saved: true), child: const Text('Guardar')),
          TextButton(onPressed: () => _goToMisCupones(context, saved: false), child: const Text('Ahora no')),
        ],
      ),
    );
  }
}

class _McStat extends StatelessWidget {
  final String value;
  final String label;
  const _McStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, height: 1)),
    const SizedBox(height: 3),
    Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.1), textAlign: TextAlign.center),
  ]);
}

class _McStatPoints extends StatelessWidget {
  final String points;
  final String label;
  const _McStatPoints({required this.points, required this.label});

  @override
  Widget build(BuildContext context) => Column(children: [
    Row(mainAxisSize: MainAxisSize.min, children: [const PointsIcon(size: 20), const SizedBox(width: 4), Text(points, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, height: 1))]),
    const SizedBox(height: 3),
    Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.1), textAlign: TextAlign.center),
  ]);
}

class _QrPainter extends CustomPainter {
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
