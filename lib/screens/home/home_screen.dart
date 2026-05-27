import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/ticket_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

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
                padding: const EdgeInsets.fromLTRB(26, 14, 26, 14),
                child: Row(children: [
                  Row(children: [
                    Image.asset('assets/images/cuponix-imagotipo-cropped.png', height: 36, fit: BoxFit.contain),
                    const SizedBox(width: 8),
                    Image.asset('assets/images/cuponix-logotipo-cropped.png', height: 26, fit: BoxFit.contain),
                  ]),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.go('/mensajes'),
                    child: Image.asset('assets/images/icon-mensajes.png', width: 36, height: 36, fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () => context.go('/configuracion'),
                    child: Image.asset('assets/images/icon-configuracion.png', width: 36, height: 36, fit: BoxFit.contain),
                  ),
                ]),
              ),
            ),
            // Feed
            Expanded(
              child: ListView(
                children: [
                  _buildCarousel(),
                  _buildTabs(),
                  Container(height: 1, color: Colors.white.withOpacity(0.18)),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(children: [
                      _CouponCard(
                        avatarBg: const Color(0xFFD4322B), avatarFg: Colors.white, avatarLabel: "Roger's",
                        name: "Roger's Smash", handle: '@rogersec',
                        discount: '20%', minCompra: r'$30,00', rewardPts: '5', expira: '17/08/26',
                      ),
                      const SizedBox(height: 18),
                      _CouponCard(
                        avatarBg: Colors.white, avatarFg: const Color(0xFF1C1C1C), avatarLabel: 'R',
                        name: 'Rukito', handle: '@rukitogrillndrinks',
                        isText: true,
                        blurb: '2 Micheladas gratis con\nla compra de un combo\nparrillero completo.',
                        rewardPts: '10', expira: '10/07/26',
                      ),
                      const SizedBox(height: 18),
                      _CouponCard(
                        avatarBg: const Color(0xFFF48FB1), avatarFg: Colors.white, avatarLabel: 'DD',
                        name: "Dunkin'", handle: '@dunkinec',
                        discount: '30%', minCompra: r'$12,00', rewardPts: '12', expira: '05/09/26',
                      ),
                      const SizedBox(height: 18),
                    ]),
                  ),
                ],
              ),
            ),
            BottomNavBar(
              active: NavTab.home,
              onTap: (t) {
                switch (t) {
                  case NavTab.home: break;
                  case NavTab.explore: context.go('/explorar');
                  case NavTab.cupones: context.go('/cupones');
                  case NavTab.perfil: context.go('/perfil');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return LayoutBuilder(builder: (_, c) {
      // Scale all three boxes + gaps to fill the available width exactly
      final r = (c.maxWidth - 16.0) / 468.0; // 468 = 110+14+220+14+110
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _promoBox(110 * r, 110 * r, '2x1', 'Whopper'),
          SizedBox(width: 14 * r),
          _promoBox(220 * r, 220 * r, 'Bonsai\nEspecial', r'$18,99'),
          SizedBox(width: 14 * r),
          _promoBox(110 * r, 110 * r, 'Chai', 'Latte'),
        ]),
      );
    });
  }

  Widget _promoBox(double w, double h, String title, String subtitle) =>
      GestureDetector(
        onTap: () => context.go('/buscar-resultados'),
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B6CB1), Color(0xFFFF073A)],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x73000000),
                blurRadius: 16,
                offset: Offset(0, 6),
              )
            ],
          ),
          padding: EdgeInsets.all((w * 0.1).clamp(8, 18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (w * 0.16).clamp(16, 34),
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              SizedBox(height: (h * 0.04).clamp(4, 10)),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: (w * 0.08).clamp(10, 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTabs() {
    return Container(
      color: AppColors.black,
      child: Stack(children: [
        Row(children: [
          _tabBtn('Para ti', 0),
          _tabBtn('Siguiendo', 1),
        ]),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: _tab == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(height: 4, decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999))),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _tabBtn(String label, int idx) => Expanded(
    child: GestureDetector(
      onTap: () => setState(() => _tab = idx),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 14),
        child: Text(label, textAlign: TextAlign.center,
          style: TextStyle(
            color: _tab == idx ? AppColors.antique : AppColors.antique.withValues(alpha: 0.75),
            fontSize: 26,
            fontWeight: FontWeight.w500,
          )),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Coupon feed card (720×240 ticket shape, fully fluid)
// ---------------------------------------------------------------------------
class _CouponCard extends StatelessWidget {
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

  const _CouponCard({
    required this.avatarBg, this.avatarFg = Colors.white, required this.avatarLabel,
    required this.name, required this.handle,
    this.isText = false, this.blurb = '',
    this.discount = '', this.minCompra = '',
    required this.rewardPts, required this.expira,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final w = constraints.maxWidth;
      // Scale relative to 520 px reference — cards stay proportional on any phone
      final s = (w / 520.0).clamp(0.5, 1.5);
      final h = w * (240.0 / 720.0);
      final vPad = 22.0 * s;
      final innerH = h - vPad * 2;
      // Reserve space for 2-line name + gap + handle, then give avatar 85% of what's left
      final textH = (2 * 14 * 1.1 + 2 + 13 * 1.1) * s; // ≈ 47.1 * s
      final av = ((innerH - textH) * 0.85).clamp(20.0, 86.0 * s);

      return GestureDetector(
        onTap: () => context.go('/negocio'),
        child: TicketCard(
        aspectRatio: 720 / 240,
        child: Padding(
          padding: EdgeInsets.fromLTRB(28 * s, vPad, 34 * s, vPad),
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Left: avatar then name+handle grouped at top
            SizedBox(
              width: av,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: av, height: av,
                    decoration: BoxDecoration(
                      color: avatarBg,
                      shape: BoxShape.circle,
                      boxShadow: const [BoxShadow(color: Color(0x62000000), blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      avatarLabel,
                      style: TextStyle(
                        color: avatarFg,
                        fontSize: (16 * s).clamp(8, 16),
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.02,
                      ),
                    ),
                  ),
                  SizedBox(height: 6 * s),
                  Text(name,
                    style: TextStyle(color: Colors.white, fontSize: (14 * s).clamp(7, 14), fontWeight: FontWeight.w500, height: 1.1),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 2 * s),
                  Text(handle,
                    style: TextStyle(color: Colors.white70, fontSize: (13 * s).clamp(7, 13), height: 1.1),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            SizedBox(width: 20 * s),
            // Right: stats on top, action pills pinned to bottom
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: isText ? [
                  Expanded(child: Text(blurb,
                    style: TextStyle(color: Colors.white, fontSize: (14 * s).clamp(7, 14), fontWeight: FontWeight.w500, height: 1.25))),
                  SizedBox(width: 10 * s),
                  _rewardCol(s),
                ] : [
                  _statCol(discount, 'Descuento', s),
                  SizedBox(width: 10 * s),
                  _statCol(minCompra, 'Compra mínima', s),
                  SizedBox(width: 10 * s),
                  _rewardCol(s),
                ]),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  _actionPill('assets/images/icon-actividad.png', s),
                  SizedBox(width: 10 * s),
                  GestureDetector(onTap: () => context.go('/guardados'), child: _pill('Guardar', s)),
                  SizedBox(width: 10 * s),
                  GestureDetector(onTap: () => context.go('/usar-cupon'), child: _pill('Usar', s)),
                ]),
              ]),
            ),
          ]),
        ),
        ),
      );
    });
  }

  Widget _statCol(String v, String l, double s) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(v, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(12, 26), fontWeight: FontWeight.w600, height: 1)),
      SizedBox(height: 2 * s),
      Text(l, style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11), height: 1.1)),
    ],
  );

  Widget _rewardCol(double s) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        PointsIcon(size: (22 * s).clamp(12, 22)),
        SizedBox(width: 4 * s),
        Text(rewardPts, style: TextStyle(color: Colors.white, fontSize: (26 * s).clamp(12, 26), fontWeight: FontWeight.w600, height: 1)),
      ]),
      Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
      SizedBox(height: 2 * s),
      Text('Expira: $expira', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
    ],
  );

  Widget _actionPill(String asset, double s) => Container(
    width: 34 * s, height: 30 * s,
    decoration: BoxDecoration(
      color: AppColors.neonRed,
      borderRadius: BorderRadius.circular(999),
      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))],
    ),
    child: Padding(padding: EdgeInsets.all(7 * s), child: Image.asset(asset, fit: BoxFit.contain)),
  );

  Widget _pill(String label, double s) => Container(
    height: 30 * s,
    padding: EdgeInsets.symmetric(horizontal: 18 * s),
    decoration: BoxDecoration(
      color: AppColors.neonRed,
      borderRadius: BorderRadius.circular(999),
      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))],
    ),
    alignment: Alignment.center,
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500)),
  );
}
