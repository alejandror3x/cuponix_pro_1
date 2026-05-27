import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/points_icon.dart';

class CrearCuponScreen extends StatefulWidget {
  const CrearCuponScreen({super.key});

  @override
  State<CrearCuponScreen> createState() => _CrearCuponScreenState();
}

class _CrearCuponScreenState extends State<CrearCuponScreen> {
  int _tab = 0; // 0=Consumo, 1=Personalizado
  double _descuento = 0;
  double _consumo = 0;
  double _puntos = 0;
  double _puntosPersonal = 0;
  final _promoCtrl = TextEditingController();
  final _fechaCtrl = TextEditingController();
  final _codigoCtrl = TextEditingController();

  @override
  void dispose() {
    _promoCtrl.dispose();
    _fechaCtrl.dispose();
    _codigoCtrl.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(children: [
                  BackTriangle(onTap: () => context.go('/cupones')),
                  const SizedBox(width: 16),
                  const Text('Crear cupón', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
            // Tabs
            _buildTabs(),
            Container(height: 1, color: Colors.white.withOpacity(0.18)),
            // Content
            Expanded(
              child: _tab == 0 ? _consumoContent() : _personalizadoContent(),
            ),
            // Footer
            _buildFooter(context),
            BottomNavBar(
              active: NavTab.cupones,
              onTap: (t) {
                switch (t) {
                  case NavTab.home: context.go('/home');
                  case NavTab.explore: break;
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

  Widget _buildTabs() {
    return Container(
      color: AppColors.black,
      child: Stack(
        children: [
          Row(children: [_tab0('Consumo', 0), _tab0('Personalizado', 1)]),
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
        ],
      ),
    );
  }

  Widget _tab0(String label, int idx) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = idx),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 18),
          child: Text(label, textAlign: TextAlign.center,
            style: TextStyle(color: _tab == idx ? AppColors.antique : AppColors.antique.withValues(alpha: 0.85), fontSize: 22, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _consumoContent() {
    return ListView(
      children: [
        _sliderBlock(
          label: 'Descuento',
          value: _descuento,
          max: 100,
          display: '${_descuento.round()}%',
          onChanged: (v) => setState(() => _descuento = v),
        ),
        _sliderBlock(
          label: 'Consumo',
          value: _consumo,
          max: 200,
          display: '\$${_consumo.round()},0',
          onChanged: (v) => setState(() => _consumo = v),
        ),
        _sliderBlock(
          label: 'Puntos a ganar',
          sublabel: '(opcional)',
          value: _puntos,
          max: 100,
          isPoints: true,
          display: '${_puntos.round()}',
          onChanged: (v) => setState(() => _puntos = v),
        ),
      ],
    );
  }

  Widget _personalizadoContent() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 14),
          child: Text('¿De qué se trata tu promoción?', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500, height: 1.2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 110,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18),
              boxShadow: const [BoxShadow(color: Color(0x4D000000), blurRadius: 8, offset: Offset(0, 2))]),
            child: TextField(
              controller: _promoCtrl,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintText: 'Escribir',
                hintStyle: TextStyle(color: Color(0x59000000)),
                contentPadding: EdgeInsets.all(14),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: AppColors.ink, fontSize: 14, height: 1.4),
            ),
          ),
        ),
        const SizedBox(height: 2),
        _sliderBlock(
          label: 'Puntos a ganar',
          sublabel: '(opcional)',
          value: _puntosPersonal,
          max: 100,
          isPoints: true,
          display: '${_puntosPersonal.round()}',
          onChanged: (v) => setState(() => _puntosPersonal = v),
        ),
      ],
    );
  }

  Widget _sliderBlock({required String label, String sublabel = '', required double value, required double max,
    required String display, bool isPoints = false, required ValueChanged<double> onChanged}) {
    return Container(
      color: Colors.white.withOpacity(0.06),
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.fromLTRB(26, 22, 26, 22),
      child: Row(children: [
        Expanded(child: Slider(
          value: value, min: 0, max: max, divisions: max.round(),
          activeColor: AppColors.neonRed,
          inactiveColor: Colors.white,
          thumbColor: AppColors.neonRed,
          onChanged: onChanged,
        )),
        const SizedBox(width: 22),
        SizedBox(
          width: 100,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              if (isPoints) ...[const PointsIcon(size: 20), const SizedBox(width: 4)],
              Text(display, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600)),
            ]),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            if (sublabel.isNotEmpty) Text(sublabel, style: const TextStyle(color: Colors.white54, fontSize: 11)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: AppColors.black,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(children: [
        const Text('Fecha de Expiración:', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        _footerInput(_fechaCtrl, 'DD/MM/AA'),
        const SizedBox(height: 12),
        const Text('Añadir código (opcional)', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        _footerInput(_codigoCtrl, ''),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => context.go('/cupon-listo'),
          child: Container(
            height: 36, padding: const EdgeInsets.symmetric(horizontal: 34),
            decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
              boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 12, offset: Offset(0, 4))]),
            alignment: Alignment.center,
            child: const Text('CREAR', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
          ),
        ),
      ]),
    );
  }

  Widget _footerInput(TextEditingController ctrl, String hint) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 30,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999),
            boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 6, offset: Offset(0, 2))]),
          child: TextField(
            controller: ctrl,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0x59000000)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: AppColors.ink, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
