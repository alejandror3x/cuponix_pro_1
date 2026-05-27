import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupones_shell.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/ticket_card.dart';

class GuardadosScreen extends StatefulWidget {
  const GuardadosScreen({super.key});

  @override
  State<GuardadosScreen> createState() => _GuardadosScreenState();
}

class _GuardadosScreenState extends State<GuardadosScreen> {
  int _sub = 0; // 0=Cupones, 1=Puntos

  @override
  Widget build(BuildContext context) {
    return CuponesShell(
      activeInner: InnerTab.guardados,
      onInnerTab: (t) => _onInner(context, t),
      activeNav: NavTab.cupones,
      onNav: (t) => _onNav(context, t),
      feed: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          const SectionTitle('Guardados'),
          SubTabBar(labels: const ['Cupones', 'Puntos'], active: _sub, onTap: (i) => setState(() => _sub = i)),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: _sub == 0 ? _cupones() : _puntos(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _cupones() => [
    _tallCard(
      avatarBg: Colors.white,
      avatarFg: const Color(0xFF1C1C1C),
      avatarLabel: 'R',
      name: 'Rukito',
      handle: '@rukitogrillndrinks',
      isText: true,
      blurb: '2 Micheladas gratis con\nla compra de un combo\nparrillero completo.',
      rewardPts: '10',
      expira: '10/07/26',
    ),
    const SizedBox(height: 18),
    _tallCard(
      avatarBg: const Color(0xFF0B6CB1),
      avatarFg: Colors.white,
      avatarLabel: 'D',
      name: "Domino's Pizza",
      handle: '@dominosec',
      discount: '15%',
      minCompra: r'$20,00',
      rewardPts: '15',
      expira: '12/12/25',
    ),
  ];

  List<Widget> _puntos() => [
    _puntosCard(avatarBg: const Color(0xFFD4322B), avatarFg: Colors.white, label: "Roger's",
      name: "Roger's", handle: '@rogersec', disponibles: '15', usadas: '0'),
    const SizedBox(height: 14),
    _puntosCard(avatarBg: const Color(0xFFFEF9E8), avatarFg: const Color(0xFF1C1C1C), label: 'T',
      name: 'Tijuana', handle: '@tijuanaec', disponibles: '50', usadas: '0'),
  ];

  Widget _tallCard({
    required Color avatarBg, required Color avatarFg, required String avatarLabel,
    required String name, required String handle,
    bool isText = false, String blurb = '',
    String discount = '', String minCompra = '',
    required String rewardPts, required String expira,
  }) {
    return LayoutBuilder(builder: (ctx, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final cardH = c.maxWidth * (240.0 / 720.0);
      final vPad = 22.0 * s;
      final innerH = cardH - vPad * 2;
      final av = (90.0 * s).clamp(20.0, innerH - 4);

      return TicketCard(
        aspectRatio: 720 / 240,
        child: Padding(
          padding: EdgeInsets.fromLTRB(28 * s, vPad, 34 * s, vPad),
          child: Row(children: [
            SizedBox(width: av, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: av, height: av,
                decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(avatarLabel, style: TextStyle(color: avatarFg, fontSize: (20 * s).clamp(10, 20), fontWeight: FontWeight.w700)),
              ),
              const Spacer(),
              Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: (15 * s).clamp(8, 15), fontWeight: FontWeight.w500)),
              Text(handle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white70, fontSize: (15 * s).clamp(8, 15))),
            ])),
            SizedBox(width: 20 * s),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (isText)
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: Text(blurb, style: TextStyle(color: Colors.white, fontSize: (15 * s).clamp(8, 15), fontWeight: FontWeight.w500, height: 1.25))),
                  SizedBox(width: 10 * s),
                  _rewardCol(rewardPts, expira, s),
                ])
              else
                Row(children: [
                  Flexible(fit: FlexFit.loose, child: _statCol(discount, 'Descuento', s)),
                  SizedBox(width: 10 * s),
                  Flexible(fit: FlexFit.loose, child: _statCol(minCompra, 'Compra mínima', s)),
                  SizedBox(width: 10 * s),
                  Flexible(fit: FlexFit.loose, child: _rewardCol(rewardPts, expira, s)),
                ]),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                _actionBtn('assets/images/icon-actividad.png', s),
                SizedBox(width: 10 * s),
                _pill('Guardar', s),
                SizedBox(width: 10 * s),
                GestureDetector(onTap: () => ctx.go('/usar-cupon'), child: _pill('Usar', s)),
              ]),
            ])),
          ]),
        ),
      );
    });
  }

  Widget _statCol(String v, String l, double s) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(v, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(13, 26), fontWeight: FontWeight.w600)),
    Text(l, style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
  ]);

  Widget _rewardCol(String pts, String expira, double s) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [PointsIcon(size: (22 * s).clamp(12, 22)), SizedBox(width: 4 * s), Text(pts, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(13, 26), fontWeight: FontWeight.w600))]),
    Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
    Text('Expira: $expira', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
  ]);

  Widget _pill(String label, double s) => Container(
    height: (30 * s).clamp(20, 30),
    padding: EdgeInsets.symmetric(horizontal: 18 * s),
    decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
    alignment: Alignment.center,
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500)),
  );

  Widget _actionBtn(String asset, double s) => Container(
    width: (34 * s).clamp(22, 34),
    height: (30 * s).clamp(20, 30),
    decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
    child: Padding(padding: EdgeInsets.all(7 * s), child: Image.asset(asset, fit: BoxFit.contain)),
  );

  Widget _puntosCard({
    required Color avatarBg, required Color avatarFg, required String label,
    required String name, required String handle,
    required String disponibles, required String usadas,
  }) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final cardH = c.maxWidth * (200.0 / 720.0);
      final vPad = 18.0 * s;
      final innerH = cardH - vPad * 2;
      final av = (90.0 * s).clamp(20.0, innerH - 4);

      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.fromLTRB(28 * s, vPad, 28 * s, vPad),
          child: Row(children: [
            Container(
              width: av, height: av,
              decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(label, style: TextStyle(color: avatarFg, fontSize: (15 * s).clamp(8, 15), fontWeight: FontWeight.w700)),
            ),
            SizedBox(width: 20 * s),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: (20 * s).clamp(10, 20), fontWeight: FontWeight.w500)),
              Text(handle, style: TextStyle(color: Colors.white70, fontSize: (15 * s).clamp(8, 15))),
            ])),
            _puntosStatCol(disponibles, 'Disponibles', s),
            SizedBox(width: 20 * s),
            _puntosStatCol(usadas, 'Usadas', s),
          ]),
        ),
      );
    });
  }

  Widget _puntosStatCol(String v, String l, double s) => Column(children: [
    Row(children: [PointsIcon(size: (22 * s).clamp(12, 22)), SizedBox(width: 4 * s), Text(v, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(13, 26), fontWeight: FontWeight.w600))]),
    Text(l, style: TextStyle(color: Colors.white70, fontSize: (12 * s).clamp(7, 12))),
  ]);

  void _onInner(BuildContext ctx, InnerTab t) {
    switch (t) {
      case InnerTab.cupones: ctx.go('/cupones');
      case InnerTab.guardados: break;
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
}
