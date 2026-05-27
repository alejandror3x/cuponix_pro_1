import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/ticket_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
                child: Row(
                  children: [
                    BackTriangle(onTap: () => context.go('/configuracion')),
                    const Expanded(
                      child: Text(
                        'Suscripción',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/fondo-negro.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
                  children: [
                    TicketCard(
                      aspectRatio: 640 / 760,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/cuponix-imagotipo-cropped.png',
                              width: 82,
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Plan Negocio',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'Crea cupones, recibe solicitudes,\npublica productos y revisa tu historial\ncomo local dentro de Cuponix.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                height: 1.32,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              '3 meses gratis',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.neonRed,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              r'luego $5.99 / mes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            PillButton(
                              label: 'SUSCRIBIRME',
                              onPressed: () => context.go('/suscripcion-activa'),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () => context.go('/plan-gratis'),
                              child: const Text(
                                'VER PLAN GRATIS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavBar(
              active: NavTab.perfil,
              onTap: (t) {
                switch (t) {
                  case NavTab.home:
                    context.go('/home');
                  case NavTab.explore:
                    context.go('/explorar');
                  case NavTab.cupones:
                    context.go('/cupones');
                  case NavTab.perfil:
                    context.go('/perfil');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
