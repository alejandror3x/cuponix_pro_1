import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/ticket_card.dart';

class SubscriptionScreen extends StatelessWidget {
  final String state;
  const SubscriptionScreen({super.key, this.state = 'gratis'});

  bool get _active => state == 'suscrito';

  void _mockWeb(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                BackTriangle(onTap: () => context.go('/configuracion')),
                Expanded(child: Text(_active ? 'Mi Suscripción' : 'Suscripción', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600))),
                const SizedBox(width: 40),
              ]),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover)),
              child: ListView(padding: const EdgeInsets.fromLTRB(22, 24, 22, 28), children: [
                TicketCard(
                  aspectRatio: 640 / 760,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
                    child: Column(children: [
                      Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 82),
                      const SizedBox(height: 18),
                      Text(_active ? 'Tu suscripción está activa' : 'Pruébalo Gratis por 3 meses', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.w700, height: 1.1)),
                      const SizedBox(height: 14),
                      if (_active) ...[
                        const Text('Disfruta cupones ilimitados\ny Puntos canjeables.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500, height: 1.3)),
                        const SizedBox(height: 18),
                        const Text('Puedes anular tu suscripción\nen cualquier momento.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.3)),
                      ] else ...[
                        const Text('Sin suscripción', textAlign: TextAlign.center, style: TextStyle(color: AppColors.neonRed, fontSize: 26, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        const Text('Días restantes: 90', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        const Text(r'$5.99 al mes', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 18),
                        const Text('Con CUPONIX dale a tus clientes\nmás razones para volver.\n\nActiva cupones ilimitados y\nrecompensas con puntos.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.3)),
                      ],
                      const Spacer(),
                      PillButton(label: _active ? 'ANULAR' : 'SUSCRIBIRME', onPressed: () => _mockWeb(context, _active ? 'Abrir web para anular suscripción' : 'Abrir web para suscribirme')),
                      if (!_active) ...[
                        const SizedBox(height: 12),
                        GestureDetector(onTap: () => _mockWeb(context, 'Abrir web para anular suscripción'), child: const Text('ANULAR SUSCRIPCIÓN', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1))),
                      ],
                    ]),
                  ),
                ),
              ]),
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
}
