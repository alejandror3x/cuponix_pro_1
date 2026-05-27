import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';

class SeguidoresScreen extends StatefulWidget {
  final int initialTab;

  const SeguidoresScreen({super.key, this.initialTab = 0});

  @override
  State<SeguidoresScreen> createState() => _SeguidoresScreenState();
}

class _SeguidoresScreenState extends State<SeguidoresScreen> {
  late int _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTab;
  }

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
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
                child: Row(
                  children: [
                    BackTriangle(onTap: () => context.go('/perfil')),
                    const Expanded(
                      child: Text('@tommyspace', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            _buildTabs(),
            Container(height: 1, color: Colors.white.withOpacity(0.32)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                children: _activeTab == 0 ? _buildSeguidos() : _buildSeguidores(),
              ),
            ),
            BottomNavBar(
              active: NavTab.perfil,
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

  Widget _buildTabs() {
    return Container(
      color: AppColors.black,
      child: Stack(
        children: [
          Row(children: [_tab(0, 'Seguidos'), _tab(1, 'Seguidores')]),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: _activeTab == 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(height: 4, decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(int idx, String label) => Expanded(
    child: GestureDetector(
      onTap: () => setState(() => _activeTab = idx),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: _activeTab == idx ? Colors.white : Colors.white70, fontSize: 26, fontWeight: FontWeight.w500)),
      ),
    ),
  );

  List<Widget> _buildSeguidos() => [
    _rowCard(const Color(0xFF5B6F8A), 'A', 'Alexis', '@alexiscuponix'),
    const SizedBox(height: 14),
    _rowCard(const Color(0xFF7A4732), 'A', 'Arlyne', '@arlynesmith'),
  ];

  List<Widget> _buildSeguidores() => [
    _rowCard(const Color(0xFFCDB38B), 'T', 'Tom', '@tommyspace'),
    const SizedBox(height: 14),
    _rowCard(const Color(0xFF5B6F8A), 'A', 'Alexis', '@alexiscuponix'),
  ];

  Widget _rowCard(Color avatarBg, String initials, String name, String handle) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final cardH = c.maxWidth * (200.0 / 720.0);
      final vPad = 14.0 * s;
      final innerH = cardH - vPad * 2;
      final av = (110.0 * s).clamp(20.0, innerH - 4);

      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28 * s, vertical: vPad),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.go('/negocio'),
                child: Container(
                  width: av, height: av,
                  decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(initials, style: TextStyle(color: Colors.white, fontSize: (20 * s).clamp(10, 20), fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(width: 20 * s),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.go('/negocio'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name, style: TextStyle(color: Colors.white, fontSize: (22 * s).clamp(11, 22), fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 2 * s),
                      Text(handle, style: TextStyle(color: Colors.white70, fontSize: (17 * s).clamp(9, 17)), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _confirmRemove(context, name),
                child: Container(
                  height: 36 * s, width: 56 * s,
                  decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999), boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
                  alignment: Alignment.center,
                  child: Text('X', style: TextStyle(color: Colors.white, fontSize: (16 * s).clamp(9, 16), fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _confirmRemove(BuildContext context, String name) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Eliminar cuenta', style: TextStyle(color: Colors.white)),
        content: Text('¿Deseas eliminar a $name de esta lista?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCELAR')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('ELIMINAR')),
        ],
      ),
    );
  }
}
