import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupones_shell.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/ticket_card.dart';

class HistorialScreen extends StatefulWidget {
  final int initialSub;

  const HistorialScreen({super.key, this.initialSub = 0});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
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
          const SectionTitle('Historial'),
          SubTabBar(labels: const ['Recibidos', 'Enviados'], active: _sub, onTap: (i) => setState(() => _sub = i)),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(children: _sub == 0 ? _recibidos() : _enviados()),
          ),
          const SizedBox(height: 28),
          Center(
            child: GestureDetector(
              onTap: () => _confirmClear(context),
              child: Container(
                height: 42, padding: const EdgeInsets.symmetric(horizontal: 48),
                decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
                  boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 14, offset: Offset(0, 5))]),
                alignment: Alignment.center,
                child: const Text('BORRAR TODO', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
              ),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  List<Widget> _enviados() => [
    _enviadoCard(
      tipo: 'Canje de Puntos', fecha: '12/11/25', handle: '@rogersec', hora: '15:45',
      centerBuilder: (s) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        PointsIcon(size: (20 * s).clamp(12, 20)),
        SizedBox(width: 4 * s),
        Text('40', style: TextStyle(color: Colors.white, fontSize: (24 * s).clamp(12, 24), fontWeight: FontWeight.w600)),
      ]),
    ),
    const SizedBox(height: 14),
    _enviadoCard(
      tipo: 'Uso de Cupón', fecha: '12/04/25', handle: '@rukitogrill', hora: '12:45',
      centerBuilder: (s) => Row(children: [
        _histStat('15%', 'Descuento', s),
        SizedBox(width: 16 * s),
        _histStat(r'$30,00', 'Compra mínima', s),
        SizedBox(width: 16 * s),
        Column(children: [
          Row(children: [PointsIcon(size: (20 * s).clamp(12, 20)), SizedBox(width: 4 * s), Text('15', style: TextStyle(color: Colors.white, fontSize: (24 * s).clamp(12, 24), fontWeight: FontWeight.w600))]),
          Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
        ]),
      ]),
    ),
  ];

  List<Widget> _recibidos() => [
    _recibidoCard(
      nombre: 'Tom', handle: '@tommyspace', accion: 'Canjeó Puntos', en: 'Big baby',
      statsBuilder: (s) => Row(children: [
        PointsIcon(size: (20 * s).clamp(12, 20)),
        SizedBox(width: 4 * s),
        Text('20', style: TextStyle(color: Colors.white, fontSize: (24 * s).clamp(12, 24), fontWeight: FontWeight.w600)),
      ]),
      hora: '15:30', fecha: '12/04/25',
    ),
    const SizedBox(height: 14),
    _recibidoCard(
      nombre: 'Alexis', handle: '@alexiscuponix', accion: 'Usó un Cupón',
      statsBuilder: (s) => Row(children: [
        _histStat('20%', 'Descuento', s),
        SizedBox(width: 16 * s),
        _histStat(r'$15,00', 'Compra mínima', s),
        SizedBox(width: 16 * s),
        Column(children: [
          Row(children: [PointsIcon(size: (20 * s).clamp(12, 20)), SizedBox(width: 4 * s), Text('15', style: TextStyle(color: Colors.white, fontSize: (22 * s).clamp(11, 22), fontWeight: FontWeight.w600))]),
          Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
        ]),
      ]),
      hora: '16:20', fecha: '14/04/25',
    ),
    const SizedBox(height: 14),
    _recibidoCard(
      nombre: 'Arlyne', handle: '@arlynesmith', accion: 'Canjeó Puntos', en: 'Big baby',
      statsBuilder: (s) => Row(children: [
        PointsIcon(size: (20 * s).clamp(12, 20)),
        SizedBox(width: 4 * s),
        Text('20', style: TextStyle(color: Colors.white, fontSize: (24 * s).clamp(12, 24), fontWeight: FontWeight.w600)),
      ]),
      hora: '17:45', fecha: '25/09/25',
    ),
    const SizedBox(height: 14),
    _recibidoCard(
      nombre: 'Melina', handle: '@melinahavoc', accion: 'Usó un Cupón',
      statsBuilder: (s) => Row(children: [
        _histStat('20%', 'Descuento', s),
        SizedBox(width: 16 * s),
        _histStat(r'$30,00', 'Compra mínima', s),
        SizedBox(width: 16 * s),
        Column(children: [
          Row(children: [PointsIcon(size: (20 * s).clamp(12, 20)), SizedBox(width: 4 * s), Text('20', style: TextStyle(color: Colors.white, fontSize: (22 * s).clamp(11, 22), fontWeight: FontWeight.w600))]),
          Text('Recompenza', style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
        ]),
      ]),
      hora: '20:30', fecha: '15/07/25',
    ),
  ];

  Widget _enviadoCard({
    required String tipo, required String fecha, required String handle,
    required String hora, required Widget Function(double s) centerBuilder,
  }) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final vPad = 18.0 * s;

      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28 * s, vertical: vPad),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                Text(tipo, style: TextStyle(color: Colors.white, fontSize: (18 * s).clamp(9, 18), fontWeight: FontWeight.w500)),
                SizedBox(width: 10 * s),
                Text(fecha, style: TextStyle(color: Colors.white70, fontSize: (15 * s).clamp(8, 15))),
              ]),
              Text(handle, style: TextStyle(color: Colors.white70, fontSize: (15 * s).clamp(8, 15))),
              Text(hora, style: TextStyle(color: Colors.white70, fontSize: (15 * s).clamp(8, 15))),
            ])),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: centerBuilder(s),
              ),
            ),
            SizedBox(width: 16 * s),
            GestureDetector(onTap: () => _confirmRemoveItem(context), child: _xBtn(s)),
          ]),
        ),
      );
    });
  }

  Widget _recibidoCard({
    required String nombre, required String handle, required String accion,
    String en = '',
    required Widget Function(double s) statsBuilder,
    required String hora, required String fecha,
  }) {
    return LayoutBuilder(builder: (_, c) {
      final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
      final vPad = 14.0 * s;

      return TicketCard(
        aspectRatio: 720 / 200,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24 * s, vPad, 24 * s, vPad),
          child: Row(children: [
            SizedBox(width: 110 * s, child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(nombre, style: TextStyle(color: Colors.white, fontSize: (18 * s).clamp(9, 18), fontWeight: FontWeight.w500)),
              Text(handle, style: TextStyle(color: Colors.white70, fontSize: (14 * s).clamp(7, 14))),
              SizedBox(height: 6 * s),
              Text(accion, style: TextStyle(color: Colors.white, fontSize: (14 * s).clamp(7, 14))),
            ])),
            SizedBox(width: 12 * s),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              if (en.isNotEmpty) ...[
                Text('En: $en', style: TextStyle(color: Colors.white, fontSize: (14 * s).clamp(7, 14))),
                SizedBox(height: 6 * s),
              ],
              statsBuilder(s),
            ])),
            Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
              GestureDetector(onTap: () => _confirmRemoveItem(context), child: _xBtn(s)),
              SizedBox(height: 10 * s),
              Text(hora, style: TextStyle(color: Colors.white70, fontSize: (13 * s).clamp(7, 13))),
              Text(fecha, style: TextStyle(color: Colors.white70, fontSize: (13 * s).clamp(7, 13))),
            ]),
          ]),
        ),
      );
    });
  }

  static Widget _histStat(String v, String l, double s) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(v, style: TextStyle(color: Colors.white, fontSize: (22 * s).clamp(11, 22), fontWeight: FontWeight.w600)),
    Text(l, style: TextStyle(color: Colors.white70, fontSize: (11 * s).clamp(7, 11))),
  ]);

  Widget _xBtn(double s) => Container(
    height: (30 * s).clamp(20, 30),
    width: (36 * s).clamp(24, 36),
    decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999),
      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))]),
    alignment: Alignment.center,
    child: Text('X', style: TextStyle(color: Colors.white, fontSize: (13 * s).clamp(8, 13), fontWeight: FontWeight.w500)),
  );

  void _onInner(BuildContext ctx, InnerTab t) {
    switch (t) {
      case InnerTab.cupones: ctx.go('/cupones');
      case InnerTab.guardados: ctx.go('/guardados');
      case InnerTab.solicitudes: ctx.go('/solicitudes');
    }
  }

  void _onNav(BuildContext ctx, NavTab t) {
    switch (t) {
      case NavTab.home: ctx.go('/home');
      case NavTab.explore: ctx.go('/explorar');
      case NavTab.cupones: ctx.go('/solicitudes');
      case NavTab.perfil: ctx.go('/perfil');
    }
  }

  void _confirmClear(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Borrar historial', style: TextStyle(color: Colors.white)),
        content: const Text('Se eliminarán todos los registros visibles.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCELAR')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('BORRAR')),
        ],
      ),
    );
  }

  void _confirmRemoveItem(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.black,
        title: const Text('Eliminar registro', style: TextStyle(color: Colors.white)),
        content: const Text('¿Deseas eliminar este registro del historial?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('CANCELAR')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('ELIMINAR')),
        ],
      ),
    );
  }
}
