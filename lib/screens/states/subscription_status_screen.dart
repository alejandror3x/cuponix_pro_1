import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/ticket_card.dart';

class SubscriptionStatusScreen extends StatelessWidget {
  final bool active;

  const SubscriptionStatusScreen({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              color: AppColors.black,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  BackTriangle(onTap: () => context.go('/suscripcion')),
                  Expanded(
                    child: Text(
                      active ? 'Plan Activo' : 'Plan Gratis',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
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
                image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: TicketCard(
                    aspectRatio: 640 / 720,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            active ? Icons.verified : Icons.timer_outlined,
                            color: AppColors.neonRed,
                            size: 82,
                          ),
                          const SizedBox(height: 22),
                          Text(
                            active ? 'Suscripción activa' : 'Prueba gratis activa',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            active
                                ? 'Tu negocio puede crear cupones sin límite visual en esta maqueta.'
                                : 'Te quedan 3 meses gratis para crear cupones antes del plan mensual.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.3),
                          ),
                          const SizedBox(height: 26),
                          PillButton(
                            label: active ? 'ADMINISTRAR' : 'SUSCRIBIRME',
                            onPressed: () => context.go('/suscripcion'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
    );
  }
}
