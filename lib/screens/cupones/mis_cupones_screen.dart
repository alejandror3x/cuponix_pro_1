import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupones_shell.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/ticket_card.dart';

class MisCuponesScreen extends StatelessWidget {
  const MisCuponesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CuponesShell(
      activeInner: InnerTab.cupones,
      onInnerTab: (t) => _onInner(context, t),
      activeNav: NavTab.cupones,
      onNav: (t) => _onNav(context, t),
      feed: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              const SectionTitle('Mis Cupones'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: _mcCard(),
              ),
            ],
          ),
          // FAB
          Positioned(
            left: 28, bottom: 28,
            child: GestureDetector(
              onTap: () => context.go('/crear-cupon'),
              child: Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  color: AppColors.neonRed, shape: BoxShape.circle,
                  boxShadow: const [BoxShadow(color: Color(0x80FF073A), blurRadius: 20, offset: Offset(0, 8))],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mcCard() {
    return LayoutBuilder(builder: (ctx, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final vPad = 18.0 * s;

      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36 * s, vertical: vPad),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _stat('20%', 'Descuento', s),
              SizedBox(width: 16 * s),
              _stat(r'$15,00', 'Compra mínima', s),
              SizedBox(width: 16 * s),
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [PointsIcon(size: (20 * s).clamp(12, 20)), SizedBox(width: 4 * s), Text('15', style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(13, 26), fontWeight: FontWeight.w600))]),
                Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
                SizedBox(height: 2 * s),
                Text('Expira: 10/07/28', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
              ]),
              const Spacer(),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                _actionBtn('assets/images/icon-actividad.png', s),
                SizedBox(height: 8 * s),
                GestureDetector(onTap: () => _confirmDeleteCoupon(ctx), child: _xBtn(s)),
              ]),
            ],
          ),
        ),
      );
    });
  }

  Widget _stat(String v, String l, double s) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(v, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(13, 26), fontWeight: FontWeight.w600)),
      Text(l, style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
    ]);
  }

  Widget _actionBtn(String asset, double s) {
    final sz = (36 * s).clamp(24.0, 36.0);
    return Container(
      width: sz, height: sz,
      decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
      child: Padding(padding: EdgeInsets.all(8 * s), child: Image.asset(asset, fit: BoxFit.contain)),
    );
  }

  Widget _xBtn(double s) {
    final sz = (36 * s).clamp(24.0, 36.0);
    return Container(
      width: sz, height: sz,
      decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
      alignment: Alignment.center,
      child: Text('X', style: TextStyle(color: Colors.white, fontSize: (15 * s).clamp(9, 15), fontWeight: FontWeight.w600)),
    );
  }

  void _onInner(BuildContext ctx, InnerTab t) {
    switch (t) {
      case InnerTab.cupones: break;
      case InnerTab.guardados: ctx.go('/guardados');
      case InnerTab.solicitudes: ctx.go('/solicitudes');
    }
  }

  void _onNav(BuildContext ctx, NavTab t) {
    switch (t) {
      case NavTab.home: ctx.go('/home');
      case NavTab.explore: break;
      case NavTab.cupones: break;
      case NavTab.perfil: ctx.go('/perfil');
    }
  }

  void _confirmDeleteCoupon(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Eliminar cupón', style: TextStyle(color: Colors.white)),
        content: const Text('¿Deseas eliminar este cupón activo?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCELAR')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('ELIMINAR')),
        ],
      ),
    );
  }
}
