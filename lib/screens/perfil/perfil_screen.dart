import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/ticket_card.dart';

class PerfilScreen extends StatefulWidget {
  final int initialTab;
  const PerfilScreen({super.key, this.initialTab = 0});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late int _profileTab;

  @override
  void initState() {
    super.initState();
    _profileTab = widget.initialTab;
  }

  void _local(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

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
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Row(children: [
                  BackTriangle(onTap: () => context.go('/home')),
                  const Expanded(child: Text('@tommyspace', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500))),
                  GestureDetector(onTap: () => context.go('/mensajes'), child: _iconBtn('assets/images/icon-mensajes.png')),
                  const SizedBox(width: 12),
                  GestureDetector(onTap: () => context.go('/configuracion'), child: _iconBtn('assets/images/icon-configuracion.png')),
                ]),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () => _showPhoto(context),
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(color: const Color(0xFFCDB38B), shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 18, offset: Offset(0, 6))]),
                        alignment: Alignment.center,
                        child: const Text('T', style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 48, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Center(child: Text('Tom', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500))),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [
                      Expanded(child: _statCell('1k', 'Seguidores', () => context.go('/seguidores?tab=seguidores'))),
                      Expanded(child: _statCell('1k', 'Seguidos', () => context.go('/seguidores?tab=seguidos'))),
                    ]),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Fundador de MySpace.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, height: 1.3))),
                  const SizedBox(height: 8),
                  const Center(child: Text('Intereses:', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))),
                  const SizedBox(height: 10),
                  Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, children: ['software', 'pc', 'mac', 'social'].map(_tag).toList()),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(0.35)))),
                    child: Row(children: [_perfilTab('assets/images/tab-actividad-activado.png', 0), Container(width: 1, height: 60, color: Colors.white.withOpacity(0.35)), _perfilTab('assets/images/tab-menu-activado.png', 1), Container(width: 1, height: 60, color: Colors.white.withOpacity(0.35)), _perfilTab('assets/images/tab-valor-activado.png', 2)]),
                  ),
                  const SizedBox(height: 18),
                  _profileTabContent(),
                ],
              ),
            ),
            BottomNavBar(
              active: NavTab.perfil,
              onTap: (t) {
                switch (t) {
                  case NavTab.home: context.go('/home');
                  case NavTab.explore: context.go('/explorar');
                  case NavTab.cupones: context.go('/solicitudes');
                  case NavTab.perfil: break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileTabContent() {
    if (_profileTab == 1) return _menuContent();
    if (_profileTab == 2) return _ratingsContent();
    return Column(children: [
      _activityCard('Cupón guardado', 'Guardaste un cupón de Rogers Smash.'),
      const SizedBox(height: 12),
      _activityCard('Nueva visita', 'Sumaste puntos en Tijuana.'),
    ]);
  }

  Widget _menuContent() => GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 0.86,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    children: const [_ProfileProduct('Producto propio', '15'), _ProfileProduct('Servicio destacado', '20')],
  );

  Widget _ratingsContent() => Column(children: [
    const Text('★★★★☆', style: TextStyle(color: AppColors.neonRed, fontSize: 36, letterSpacing: 3)),
    const SizedBox(height: 10),
    _reviewCard('Rukito', 'Muy buen usuario, volvió por más promociones.'),
    const SizedBox(height: 12),
    _reviewCard('Tijuana', 'Canje rápido y buena comunicación.'),
  ]);

  Widget _activityCard(String title, String text) => TicketCard(
    aspectRatio: 720 / 180,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Row(children: [
        Container(width: 52, height: 52, decoration: const BoxDecoration(color: AppColors.neonRed, shape: BoxShape.circle), child: const Icon(Icons.bolt, color: Colors.white)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)), Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14))])),
      ]),
    ),
  );

  Widget _reviewCard(String name, String text) => TicketCard(
    aspectRatio: 720 / 170,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Row(children: [
        CircleAvatar(backgroundColor: const Color(0xFF5B6F8A), child: Text(name.substring(0, 1))),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)), Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14))])),
      ]),
    ),
  );

  Widget _iconBtn(String asset) => SizedBox(width: 36, height: 36, child: Image.asset(asset, fit: BoxFit.contain));

  Widget _statCell(String value, String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Column(children: [Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)), const SizedBox(height: 2), Text(label, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))]),
  );

  Widget _tag(String label) => Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7), decoration: BoxDecoration(border: Border.all(color: AppColors.neonRed, width: 1.5), borderRadius: BorderRadius.circular(999)), child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)));

  Widget _perfilTab(String asset, int idx) => Expanded(
    child: GestureDetector(
      onTap: () => setState(() => _profileTab = idx),
      child: AspectRatio(aspectRatio: 1, child: Center(child: Opacity(opacity: _profileTab == idx ? 1 : 0.55, child: Image.asset(asset, width: 54, height: 54, fit: BoxFit.contain)))),
    ),
  );

  void _showPhoto(BuildContext context) {
    showDialog<void>(context: context, builder: (_) => Dialog(backgroundColor: Colors.transparent, child: Container(width: 260, height: 260, decoration: const BoxDecoration(color: Color(0xFFCDB38B), shape: BoxShape.circle), alignment: Alignment.center, child: const Text('T', style: TextStyle(color: Color(0xFF1C1C1C), fontSize: 72, fontWeight: FontWeight.w700)))));
  }
}

class _ProfileProduct extends StatelessWidget {
  final String name;
  final String points;
  const _ProfileProduct(this.name, this.points);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: const Color(0xE0555555), borderRadius: BorderRadius.circular(14)),
    padding: const EdgeInsets.all(12),
    child: Column(children: [
      Expanded(child: Container(decoration: BoxDecoration(color: const Color(0xFF6B6B6B), borderRadius: BorderRadius.circular(12)), alignment: Alignment.center, child: const Icon(Icons.local_offer, color: Colors.white70, size: 42))),
      const SizedBox(height: 10),
      Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [const PointsIcon(size: 18), const SizedBox(width: 4), Text(points, style: const TextStyle(color: Colors.white, fontSize: 18))]),
    ]),
  );
}
