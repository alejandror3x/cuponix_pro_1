import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';

class BusinessFollowersScreen extends StatefulWidget {
  const BusinessFollowersScreen({super.key});

  @override
  State<BusinessFollowersScreen> createState() =>
      _BusinessFollowersScreenState();
}

class _BusinessFollowersScreenState extends State<BusinessFollowersScreen> {
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
                    BackTriangle(onTap: () => context.go('/negocio')),
                    const Expanded(
                      child: Text(
                        '@rogersec',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
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
                children: (_tab == 0 ? _seguidos : _seguidores)
                    .map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _FollowerCard(account: a),
                        ))
                    .toList(),
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

  Widget _tabs() => Container(
        color: AppColors.black,
        child: Stack(
          children: [
            Row(
              children: [
                _tabButton(0, 'Seguidos'),
                _tabButton(1, 'Seguidores'),
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
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
}

class _FollowerCard extends StatelessWidget {
  final _Account account;

  const _FollowerCard({required this.account});

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
              backgroundColor: account.color,
              child: Text(
                account.initial,
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
                    account.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    account.handle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: AppColors.neonRed,
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.center,
              child: const Text(
                'SEGUIR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _seguidos = [
  _Account('R', 'Rukito', '@rukitogrillndrinks', Colors.white),
  _Account('T', 'Tijuana', '@tijuanaec', Color(0xFF5B6F8A)),
];

const _seguidores = [
  _Account('A', 'Alexis', '@alexiscuponix', Color(0xFF5B6F8A)),
  _Account('A', 'Arlyne', '@arlynesmith', Color(0xFF7A4732)),
];

class _Account {
  final String initial;
  final String name;
  final String handle;
  final Color color;

  const _Account(this.initial, this.name, this.handle, this.color);
}
