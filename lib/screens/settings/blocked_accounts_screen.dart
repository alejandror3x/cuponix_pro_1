import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';

class BlockedAccountsScreen extends StatelessWidget {
  const BlockedAccountsScreen({super.key});

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
                        'Bloqueados',
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
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                  children: const [
                    _BlockedCard(
                      initial: 'A',
                      name: 'Alexis',
                      handle: '@alexiscuponix',
                      color: Color(0xFF5B6F8A),
                    ),
                    SizedBox(height: 14),
                    _BlockedCard(
                      initial: 'D',
                      name: "Domino's Pizza",
                      handle: '@dominosec',
                      color: Color(0xFF0B6CB1),
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

class _BlockedCard extends StatelessWidget {
  final String initial;
  final String name;
  final String handle;
  final Color color;

  const _BlockedCard({
    required this.initial,
    required this.name,
    required this.handle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      aspectRatio: 720 / 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: color,
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    handle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.neonRed,
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.center,
              child: const Text(
                'DESBLOQUEAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
