import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupones_shell.dart';
import '../../core/widgets/ticket_card.dart';

class SolicitudesScreen extends StatefulWidget {
  final int initialSub;

  const SolicitudesScreen({super.key, this.initialSub = 0});

  @override
  State<SolicitudesScreen> createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
  late int _sub;

  @override
  void initState() {
    super.initState();
    _sub = widget.initialSub;
  }

  @override
  Widget build(BuildContext context) {
    return CuponesShell(
      activeInner: InnerTab.solicitudes,
      onInnerTab: (t) => _onInner(context, t),
      activeNav: NavTab.cupones,
      onNav: (t) => _onNav(context, t),
      feed: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          const SectionTitle('Solicitudes'),
          SubTabBar(labels: const ['Recibidas', 'Enviadas'], active: _sub, onTap: (i) => setState(() => _sub = i)),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(children: _sub == 0 ? _recibidas(context) : _enviadas(context)),
          ),
          const SizedBox(height: 28),
          Center(
            child: GestureDetector(
              onTap: () => context.go(_sub == 0 ? '/historial' : '/historial?tab=enviados'),
              child: Container(
                height: 42, padding: const EdgeInsets.symmetric(horizontal: 48),
                decoration: BoxDecoration(
                  color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
                  boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 14, offset: Offset(0, 5))],
                ),
                alignment: Alignment.center,
                child: const Text('HISTORIAL', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
              ),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  List<Widget> _recibidas(BuildContext ctx) => [
    _reqCard(avatarBg: const Color(0xFFCDB38B), label: 'T', name: 'Tom', handle: '@tommyspace',
      action: 'Solicitó Usar Puntos', ctx: ctx, route: '/solicitud-canje'),
    const SizedBox(height: 14),
    _reqCard(avatarBg: const Color(0xFF5B6F8A), avatarFg: Colors.white, label: 'A', name: 'Alexis', handle: '@alexiscuponix',
      action: 'Solicitó Usar Cupón', ctx: ctx, route: '/solicitud-cupon'),
    const SizedBox(height: 14),
    _reqCard(avatarBg: const Color(0xFF7A4732), avatarFg: Colors.white, label: 'A', name: 'Arlyne', handle: '@arlynesmith',
      action: 'Solicitó Usar Puntos', ctx: ctx, route: '/solicitud-canje'),
  ];

  List<Widget> _enviadas(BuildContext ctx) => [
    _reqCard(avatarBg: const Color(0xFFFEF9E8), avatarFg: const Color(0xFF1C1C1C), label: 'T', name: 'Tijuana', handle: '@tijuanaec',
      action: 'Solicitud de Puntos', ctx: ctx, route: '/mostrar-qr'),
    const SizedBox(height: 14),
    _reqCard(avatarBg: const Color(0xFFD4322B), avatarFg: Colors.white, label: "R", name: "Roger's Smash", handle: '@rogersec',
      action: 'Solicitud de Cupón', ctx: ctx, route: '/mostrar-codigo'),
  ];

  Widget _reqCard({
    required Color avatarBg, Color avatarFg = const Color(0xFF1C1C1C),
    required String label, required String name, required String handle,
    required String action, required BuildContext ctx, required String route,
  }) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final cardH = c.maxWidth * (200.0 / 720.0);
      final vPad = 14.0 * s;
      final innerH = cardH - vPad * 2;
      final av = (90.0 * s).clamp(20.0, innerH - 4);

      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.fromLTRB(22 * s, vPad, 28 * s, vPad),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: av, height: av,
              decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(label, style: TextStyle(color: avatarFg, fontSize: (16 * s).clamp(8, 16), fontWeight: FontWeight.w700)),
            ),
            SizedBox(width: 18 * s),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: (20 * s).clamp(10, 20), fontWeight: FontWeight.w500)),
              Text(handle, style: TextStyle(color: Colors.white70, fontSize: (16 * s).clamp(8, 16))),
            ])),
            Flexible(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(action, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: (18 * s).clamp(9, 18)), textAlign: TextAlign.right),
              SizedBox(height: 10 * s),
              Row(children: [
                _pill('VER', () => ctx.go(route), s),
                SizedBox(width: 10 * s),
                GestureDetector(onTap: () => _confirmRemove(ctx), child: _xBtn(s)),
              ]),
            ])),
          ]),
        ),
      );
    });
  }

  Widget _pill(String label, VoidCallback onTap, double s) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: (30 * s).clamp(20, 30),
      padding: EdgeInsets.symmetric(horizontal: 18 * s),
      decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500, letterSpacing: 0.6)),
    ),
  );

  Widget _xBtn(double s) => Container(
    height: (30 * s).clamp(20, 30),
    width: (36 * s).clamp(24, 36),
    decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
    alignment: Alignment.center,
    child: Text('X', style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500)),
  );

  void _confirmRemove(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Eliminar solicitud', style: TextStyle(color: Colors.white)),
        content: const Text('¿Deseas eliminar esta solicitud?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCELAR')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('ELIMINAR')),
        ],
      ),
    );
  }

  void _onInner(BuildContext ctx, InnerTab t) {
    switch (t) {
      case InnerTab.cupones: ctx.go('/cupones');
      case InnerTab.guardados: ctx.go('/guardados');
      case InnerTab.solicitudes: break;
    }
  }

  void _onNav(BuildContext ctx, NavTab t) {
    switch (t) {
      case NavTab.home: ctx.go('/home');
      case NavTab.explore: ctx.go('/explorar');
      case NavTab.cupones: break;
      case NavTab.perfil: ctx.go('/perfil');
    }
  }
}
