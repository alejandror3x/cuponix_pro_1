import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({super.key});

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
                    BackTriangle(onTap: () => context.go('/perfil')),
                    const Expanded(
                      child: Text(
                        'Configuración',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover)),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                  children: [
                    _option(context, 'Editar Perfil', '/editar-perfil-config'),
                    _option(context, 'Editar Cuenta', '/editar-cuenta'),
                    _option(context, 'Editar Producto', '/editar-producto'),
                    _option(context, 'Bloqueos', '/bloqueados'),
                    _option(context, 'Suscripción', '/suscripcion?estado=gratis'),
                    _option(context, 'Permisos', '/permisos'),
                    _option(context, 'Términos y Condiciones', '/terminos'),
                    _option(context, 'Ayuda', '/ayuda'),
                    _option(context, 'Cerrar Sesión', '/login', danger: true),
                  ],
                ),
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

  Widget _option(BuildContext context, String label, String? route, {bool danger = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: GestureDetector(
      onTap: route == null ? null : () => context.go(route),
      child: TicketCard(
        aspectRatio: 720 / 135,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(child: Text(label, style: TextStyle(color: danger ? AppColors.neonRed : Colors.white, fontSize: 21, fontWeight: FontWeight.w600))),
              Icon(Icons.chevron_right, color: danger ? AppColors.neonRed : Colors.white, size: 30),
            ],
          ),
        ),
      ),
    ),
  );
}
