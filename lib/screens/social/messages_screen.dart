import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _tab = 0;

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
                    BackTriangle(onTap: () => context.go('/home')),
                    Expanded(
                      child: Text(
                        _tab == 0 ? 'Mensajes' : 'Notificaciones',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            _tabs(),
            Container(height: 1, color: Colors.white.withValues(alpha: 0.32)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                children: _tab == 0 ? _messages(context) : _notifications(context),
              ),
            ),
            BottomNavBar(
              active: NavTab.home,
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

  Widget _tabs() => Container(
        color: AppColors.black,
        child: Stack(
          children: [
            Row(
              children: [
                _tabButton(0, 'Mensajes'),
                _tabButton(1, 'Notificaciones'),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: _tab == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.neonRed,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _tabButton(int idx, String label) => Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _tab = idx),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _tab == idx ? Colors.white : Colors.white70,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  List<Widget> _messages(BuildContext context) => [
        _InboxCard(
          avatar: "R",
          name: "Roger's Smash",
          handle: '@rogersec',
          text: 'Hola, tu cupón está listo para usar.',
          action: 'VER',
          onAction: () => context.go('/chat'),
        ),
        const SizedBox(height: 14),
        _InboxCard(
          avatar: 'T',
          name: 'Tijuana',
          handle: '@tijuanaec',
          text: 'Gracias por seguirnos.',
          action: 'VER',
          onAction: () => context.go('/chat'),
        ),
      ];

  List<Widget> _notifications(BuildContext context) => [
        _InboxCard(
          avatar: 'A',
          name: 'Alexis',
          handle: '@alexiscuponix',
          text: 'Solicitó seguirte.',
          action: 'ACEPTAR',
          onAction: () {},
        ),
        const SizedBox(height: 14),
        _InboxCard(
          avatar: 'R',
          name: "Roger's Smash",
          handle: '@rogersec',
          text: 'Calificó tu perfil.',
          action: 'VER',
          onAction: () => context.go('/negocio'),
        ),
        const SizedBox(height: 14),
        _InboxCard(
          avatar: 'D',
          name: "Domino's Pizza",
          handle: '@dominosec',
          text: 'Compartió un cupón.',
          action: 'VER',
          onAction: () => context.go('/buscar-resultados'),
        ),
      ];
}

class _InboxCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String handle;
  final String text;
  final String action;
  final VoidCallback onAction;

  const _InboxCard({
    required this.avatar,
    required this.name,
    required this.handle,
    required this.text,
    required this.action,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      aspectRatio: 720 / 210,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: const Color(0xFFD4322B),
              child: Text(
                avatar,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 16),
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
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    handle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pill(action, onAction),
                const SizedBox(height: 8),
                _pill('X', () {}, compact: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String label, VoidCallback onTap, {bool compact = false}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 32,
          width: compact ? 44 : null,
          padding: compact ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.neonRed,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
}
