import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';
import '../../core/widgets/points_icon.dart';

class BuscarResultadosScreen extends StatefulWidget {
  const BuscarResultadosScreen({super.key});

  @override
  State<BuscarResultadosScreen> createState() => _BuscarResultadosScreenState();
}

class _BuscarResultadosScreenState extends State<BuscarResultadosScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
                child: Row(children: [
                  BackTriangle(onTap: () => context.go('/explorar')),
                  const Spacer(),
                  GestureDetector(onTap: () => context.go('/mensajes'), child: Image.asset('assets/images/icon-mensajes.png', width: 32, height: 32, fit: BoxFit.contain)),
                  const SizedBox(width: 12),
                  GestureDetector(onTap: () => context.go('/configuracion'), child: Image.asset('assets/images/icon-configuracion.png', width: 32, height: 32, fit: BoxFit.contain)),
                ]),
              ),
            ),
            Container(
              color: AppColors.black,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999), boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 6, offset: Offset(0, 2))]),
                    child: const TextField(
                      style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8), isDense: true),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Búsqueda actualizada'))),
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(color: _tab == 1 ? AppColors.neonRed : AppColors.purple, borderRadius: BorderRadius.circular(999)),
                    alignment: Alignment.center,
                    child: const Text('ENVIAR', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  ),
                ),
              ]),
            ),
            Container(
              color: AppColors.black,
              child: Stack(children: [
                Row(children: [_tabBtn('Cuentas', 0), _tabBtn('Cupones', 1)]),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: _tab == 0 ? Alignment.centerLeft : Alignment.centerRight,
                    child: FractionallySizedBox(widthFactor: 0.5, child: Container(height: 4, decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)))),
                  ),
                ),
              ]),
            ),
            Container(height: 1, color: Colors.white.withValues(alpha: 0.32)),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover, alignment: Alignment.topCenter)),
                child: ListView(padding: const EdgeInsets.fromLTRB(14, 14, 14, 100), children: _tab == 0 ? _buildCuentas() : _buildCupones()),
              ),
            ),
            BottomNavBar(
              active: NavTab.explore,
              onTap: (t) {
                switch (t) {
                  case NavTab.home: context.go('/home');
                  case NavTab.explore: context.go('/explorar');
                  case NavTab.cupones: context.go('/solicitudes');
                  case NavTab.perfil: context.go('/perfil');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBtn(String label, int idx) => Expanded(
    child: GestureDetector(
      onTap: () => setState(() => _tab = idx),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 18),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withValues(alpha: _tab == idx ? 1.0 : 0.75), fontSize: 26, fontWeight: FontWeight.w500)),
      ),
    ),
  );

  List<Widget> _buildCuentas() => const [
    _AccountCard(avatarBg: Color(0xFFFEF9E8), avatarFg: Color(0xFF1C1C1C), avatarLabel: 'T', name: 'Tijuana', handle: '@tijuanaec'),
    SizedBox(height: 14),
    _AccountCard(avatarBg: Colors.white, avatarFg: Color(0xFF1C1C1C), avatarLabel: 'R', name: 'Rukito', handle: '@rukitoec'),
  ];

  List<Widget> _buildCupones() => [
    _ResultCouponCard(avatarBg: const Color(0xFFD4322B), avatarFg: Colors.white, avatarLabel: "Roger's", name: "Roger's Smash", handle: '@rogersec', discount: '20%', minCompra: r'$15,00', rewardPts: '5', expira: '12/12/25', onUsar: () => context.go('/usar-cupon')),
    const SizedBox(height: 14),
    _ResultCouponCard(avatarBg: const Color(0xFF0B6CB1), avatarFg: Colors.white, avatarLabel: 'BR', name: 'Baskin Robbins', handle: '@baskinrobbinsec', isText: true, blurb: '2x1 en conos simples\ncon 3 toppings', rewardPts: '9', expira: '5/03/26', onUsar: () => context.go('/usar-cupon')),
  ];
}

class _AccountCard extends StatelessWidget {
  final Color avatarBg;
  final Color avatarFg;
  final String avatarLabel;
  final String name;
  final String handle;

  const _AccountCard({required this.avatarBg, required this.avatarFg, required this.avatarLabel, required this.name, required this.handle});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28 * s, vertical: 14 * s),
          child: Row(children: [
            GestureDetector(onTap: () => context.go('/negocio'), child: _avatar(s)),
            SizedBox(width: 14 * s),
            Expanded(child: GestureDetector(onTap: () => context.go('/negocio'), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: (22 * s).clamp(11, 22), fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(handle, style: TextStyle(color: Colors.white70, fontSize: (17 * s).clamp(9, 17)), maxLines: 1, overflow: TextOverflow.ellipsis),
            ]))),
            GestureDetector(onTap: () => _local(context, 'Ahora sigues a $name'), child: _pill('SEGUIR', s)),
            SizedBox(width: 8 * s),
            GestureDetector(onTap: () => _local(context, '$name ocultado'), child: _xBtn(s)),
          ]),
        ),
      );
    });
  }

  Widget _avatar(double s) => Container(
    width: (96 * s).clamp(38, 96), height: (96 * s).clamp(38, 96),
    decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
    alignment: Alignment.center,
    child: Text(avatarLabel, style: TextStyle(color: avatarFg, fontSize: (16 * s).clamp(8, 16), fontWeight: FontWeight.w700)),
  );

  Widget _pill(String label, double s) => Container(height: (34 * s).clamp(22, 34), padding: EdgeInsets.symmetric(horizontal: 16 * s), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: Text(label, style: TextStyle(color: Colors.white, fontSize: (12 * s).clamp(8, 12), fontWeight: FontWeight.w500)));
  Widget _xBtn(double s) => Container(height: (34 * s).clamp(22, 34), width: (38 * s).clamp(24, 38), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: Text('X', style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500)));
  void _local(BuildContext context, String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

class _ResultCouponCard extends StatelessWidget {
  final Color avatarBg;
  final Color avatarFg;
  final String avatarLabel;
  final String name;
  final String handle;
  final bool isText;
  final String blurb;
  final String discount;
  final String minCompra;
  final String rewardPts;
  final String expira;
  final VoidCallback onUsar;

  const _ResultCouponCard({required this.avatarBg, this.avatarFg = Colors.white, required this.avatarLabel, required this.name, required this.handle, this.isText = false, this.blurb = '', this.discount = '', this.minCompra = '', required this.rewardPts, required this.expira, required this.onUsar});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      return TicketCard(
        aspectRatio: 720 / 260,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24 * s, 18 * s, 28 * s, 18 * s),
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(width: 92 * s, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 76 * s, height: 76 * s, decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle), alignment: Alignment.center, child: Text(avatarLabel, style: TextStyle(color: avatarFg, fontSize: (15 * s).clamp(8, 15), fontWeight: FontWeight.w800))),
              const Spacer(),
              Text(name, style: TextStyle(color: Colors.white, fontSize: (14 * s).clamp(7, 14), fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
              Text(handle, style: TextStyle(color: Colors.white70, fontSize: (13 * s).clamp(7, 13)), maxLines: 1, overflow: TextOverflow.ellipsis),
            ])),
            SizedBox(width: 18 * s),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              isText ? Row(children: [Expanded(child: Text(blurb, style: TextStyle(color: Colors.white, fontSize: (14 * s).clamp(7, 14), fontWeight: FontWeight.w500))), SizedBox(width: 10 * s), _rewardCol(s)]) : Row(children: [_statCol(discount, 'Descuento', s), SizedBox(width: 10 * s), _statCol(minCompra, 'Compra mínima', s), SizedBox(width: 10 * s), _rewardCol(s)]),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(onTap: () => _local(context, 'Actividad agregada al perfil'), child: _iconPill(s)),
                SizedBox(width: 10 * s),
                _textPill('Guardar', () => _local(context, 'Cupón guardado'), s),
                SizedBox(width: 10 * s),
                _textPill('Usar', onUsar, s),
              ]),
            ])),
          ]),
        ),
      );
    });
  }

  Widget _statCol(String v, String l, double s) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(12, 26), fontWeight: FontWeight.w600)), Text(l, style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11)))]);
  Widget _rewardCol(double s) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [PointsIcon(size: (22 * s).clamp(12, 22)), SizedBox(width: 4 * s), Text(rewardPts, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(12, 26), fontWeight: FontWeight.w600))]), Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))), Text('Expira: $expira', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11)))]);
  Widget _iconPill(double s) => Container(width: 34 * s, height: 30 * s, decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), child: Padding(padding: EdgeInsets.all(7 * s), child: Image.asset('assets/images/icon-actividad.png', fit: BoxFit.contain)));
  Widget _textPill(String label, VoidCallback onTap, double s) => GestureDetector(onTap: onTap, child: Container(height: 30 * s, padding: EdgeInsets.symmetric(horizontal: 18 * s), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: Text(label, style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500))));
  void _local(BuildContext context, String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
