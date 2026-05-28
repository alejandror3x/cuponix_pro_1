import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/ticket_card.dart';

class BusinessPublicProfileScreen extends StatefulWidget {
  final int initialTab;
  const BusinessPublicProfileScreen({super.key, this.initialTab = 0});

  @override
  State<BusinessPublicProfileScreen> createState() => _BusinessPublicProfileScreenState();
}

class _BusinessPublicProfileScreenState extends State<BusinessPublicProfileScreen> {
  late int _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialTab;
  }

  void _local(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  void _showOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.black,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _option('Reportar', () {
                Navigator.of(context).pop();
                context.go('/reportar');
              }),
              _option('Bloquear', () {
                Navigator.of(context).pop();
                context.go('/bloqueados?agregado=roger');
              }),
              _option('Compartir', () {
                Navigator.of(context).pop();
                _local('Perfil compartido');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(String label, VoidCallback onTap) => ListTile(
    onTap: onTap,
    title: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
  );

  void _showPhoto() {
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 260,
          height: 260,
          decoration: const BoxDecoration(color: Color(0xFFD4322B), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: const Text("Roger's", style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(children: [
          SafeArea(
            bottom: false,
            child: Container(
              color: AppColors.black,
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: Row(children: [
                BackTriangle(onTap: () => Navigator.of(context).canPop() ? context.pop() : context.go('/home')),
                const Expanded(child: Text('@rogersec', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500))),
                GestureDetector(onTap: () => context.go('/mensajes'), child: Image.asset('assets/images/icon-mensajes.png', width: 36, height: 36)),
                const SizedBox(width: 12),
                GestureDetector(onTap: _showOptions, child: const Icon(Icons.more_horiz, color: Colors.white, size: 34)),
              ]),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                _header(),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: _action('SEGUIR', () => _local('Cuenta añadida a seguidos'))),
                  const SizedBox(width: 10),
                  Expanded(child: _action('MENSAJE', () => context.go('/chat'))),
                  const SizedBox(width: 10),
                  Expanded(child: _action('MAPA', () => context.go('/mapa-negocio'))),
                ]),
                const SizedBox(height: 16),
                const Text('Smash burgers, papas y malteadas en el centro. Promos nuevas cada semana.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, height: 1.25, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                const Text('Acepta pagos:', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, children: ['Efectivo', 'Tarjeta', 'Transferencia'].map(_tag).toList()),
                const SizedBox(height: 10),
                Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, children: ['Hamburguesa', 'Restaurante', 'Bebidas'].map(_tag).toList()),
                const SizedBox(height: 18),
                _tabs(),
                const SizedBox(height: 14),
                ..._body(),
              ],
            ),
          ),
          BottomNavBar(active: NavTab.perfil, onTap: (t) {
            switch (t) {
              case NavTab.home: context.go('/home');
              case NavTab.explore: context.go('/explorar');
              case NavTab.cupones: context.go('/solicitudes');
              case NavTab.perfil: context.go('/perfil');
            }
          }),
        ]),
      ),
    );
  }

  Widget _header() => Column(children: [
    GestureDetector(onTap: _showPhoto, child: Container(width: 164, height: 164, decoration: const BoxDecoration(color: Color(0xFFD4322B), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x66000000), blurRadius: 18, offset: Offset(0, 6))]), alignment: Alignment.center, child: const Text("Roger's", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic)))),
    const SizedBox(height: 12),
    const Text("Roger's Smash", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500)),
    const SizedBox(height: 8),
    Row(children: [
      Expanded(child: _stat('1k', 'Seguidores', () => context.go('/negocio-seguidores?tab=seguidores'))),
      Expanded(child: _stat('215', 'Seguidos', () => context.go('/negocio-seguidores?tab=seguidos'))),
    ]),
  ]);

  Widget _stat(String value, String label, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Column(children: [Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)), Text(label, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500))]));
  Widget _action(String label, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(height: 34, decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))));
  Widget _tag(String label) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7), decoration: BoxDecoration(border: Border.all(color: AppColors.neonRed, width: 1.4), borderRadius: BorderRadius.circular(999)), child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)));
  Widget _tabs() => Container(decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withValues(alpha: 0.35)))), child: Row(children: [_tabButton(0, 'assets/images/tab-actividad'), _divider(), _tabButton(1, 'assets/images/tab-menu'), _divider(), _tabButton(2, 'assets/images/tab-valor')]));
  Widget _tabButton(int idx, String key) => Expanded(child: GestureDetector(onTap: () => setState(() => _tab = idx), child: SizedBox(height: 78, child: Center(child: Image.asset('$key-${_tab == idx ? 'activado' : 'desactivado'}.png', width: 54, height: 54)))));
  Widget _divider() => Container(width: 1, height: 78, color: Colors.white.withValues(alpha: 0.35));

  List<Widget> _body() {
    if (_tab == 1) return [_menuGrid()];
    if (_tab == 2) return [_ratingsPanel()];
    return [_couponCard(), const SizedBox(height: 14), _textCouponCard()];
  }

  Widget _couponCard() => TicketCard(aspectRatio: 720 / 240, child: Padding(padding: const EdgeInsets.fromLTRB(22, 18, 24, 18), child: Row(children: [const CircleAvatar(radius: 34, backgroundColor: Color(0xFFD4322B), child: Text('R', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))), const SizedBox(width: 18), const Expanded(child: Row(children: [_MiniStat(value: '20%', label: 'Descuento'), SizedBox(width: 12), _MiniStat(value: r'$30,00', label: 'Compra mínima'), SizedBox(width: 12), _MiniPoints(points: '5')])), _smallPill('Guardar', () => _local('Cupón guardado')), const SizedBox(width: 8), _smallPill('Usar', () => context.go('/usar-cupon'))])));
  Widget _textCouponCard() => TicketCard(aspectRatio: 720 / 220, child: const Padding(padding: EdgeInsets.all(22), child: Row(children: [Expanded(child: Text('Combo smash + papas con bebida gratis los jueves.', style: TextStyle(color: Colors.white, fontSize: 17, height: 1.2, fontWeight: FontWeight.w500))), _MiniPoints(points: '10')])));
  Widget _menuGrid() => GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 0.82, mainAxisSpacing: 12, crossAxisSpacing: 12, children: const [_ProductTile('Smash Bacon', '25'), _ProductTile('Cheese Burger', '18'), _ProductTile('Papas Roger', '12'), _ProductTile('Malteada', '15')]);
  Widget _ratingsPanel() => Column(children: [const Text('★★★★☆', style: TextStyle(color: AppColors.neonRed, fontSize: 38, letterSpacing: 3)), const SizedBox(height: 8), Container(height: 92, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.34), borderRadius: BorderRadius.circular(20)), alignment: Alignment.topLeft, child: const Text('Escribe tu comentario...', style: TextStyle(color: Colors.white70, fontSize: 15))), const SizedBox(height: 12), GestureDetector(onTap: () => _local('Valoración enviada'), child: Container(height: 34, padding: const EdgeInsets.symmetric(horizontal: 28), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: const Text('CALIFICAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))), const SizedBox(height: 16), _review('Alexis', 'Las hamburguesas son muy buenas.'), const SizedBox(height: 12), _review('Arlyne', 'Buen servicio y puntos faciles de usar.')]);
  Widget _review(String name, String text) => TicketCard(aspectRatio: 720 / 170, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), child: Row(children: [CircleAvatar(backgroundColor: const Color(0xFF5B6F8A), child: Text(name.substring(0, 1))), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)), Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14))]))])));
  Widget _smallPill(String label, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(height: 30, padding: const EdgeInsets.symmetric(horizontal: 14), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))));
}

class _ProductTile extends StatelessWidget {
  final String name;
  final String points;
  const _ProductTile(this.name, this.points);
  @override
  Widget build(BuildContext context) => Container(decoration: BoxDecoration(color: const Color(0xE0555555), borderRadius: BorderRadius.circular(14)), padding: const EdgeInsets.all(12), child: Column(children: [Expanded(child: Container(decoration: BoxDecoration(color: const Color(0xFF6B6B6B), borderRadius: BorderRadius.circular(12)), alignment: Alignment.center, child: const Icon(Icons.fastfood, color: Colors.white70, size: 42))), const SizedBox(height: 10), Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 8), Row(mainAxisAlignment: MainAxisAlignment.center, children: [const PointsIcon(size: 18), const SizedBox(width: 4), Text(points, style: const TextStyle(color: Colors.white, fontSize: 18))]), const SizedBox(height: 8), Row(mainAxisAlignment: MainAxisAlignment.center, children: [_smallAction(context, 'VER', '/producto-detalle'), const SizedBox(width: 8), _smallAction(context, 'CANJEAR', '/canjear-puntos')])])) ;
  Widget _smallAction(BuildContext context, String label, String route) => GestureDetector(onTap: () => context.go(route), child: Container(height: 30, padding: const EdgeInsets.symmetric(horizontal: 13), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))));
}
class _MiniStat extends StatelessWidget { final String value; final String label; const _MiniStat({required this.value, required this.label}); @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10))]); }
class _MiniPoints extends StatelessWidget { final String points; const _MiniPoints({required this.points}); @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const PointsIcon(size: 18), const SizedBox(width: 4), Text(points, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600))]), const Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: 10)), const Text('Expira: 17/08/26', style: TextStyle(color: Colors.white70, fontSize: 10))]); }
