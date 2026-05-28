import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/ticket_card.dart';

class BlockedAccountsScreen extends StatefulWidget {
  const BlockedAccountsScreen({super.key});

  @override
  State<BlockedAccountsScreen> createState() => _BlockedAccountsScreenState();
}

class _BlockedAccountsScreenState extends State<BlockedAccountsScreen> {
  List<_BlockedAccount>? _accounts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_accounts != null) return;
    final added = GoRouterState.of(context).uri.queryParameters['agregado'];
    _accounts = [
      if (added == 'roger') const _BlockedAccount('R', "Roger's Smash", '@rogersec', Color(0xFFD4322B)),
      const _BlockedAccount('A', 'Alexis', '@alexiscuponix', Color(0xFF5B6F8A)),
      const _BlockedAccount('D', 'Dominos Pizza', '@dominosec', Color(0xFF0B6CB1)),
    ];
  }

  void _unblock(_BlockedAccount account) {
    setState(() => _accounts!.remove(account));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${account.name} desbloqueado')));
  }

  @override
  Widget build(BuildContext context) {
    final accounts = _accounts ?? const <_BlockedAccount>[];
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
                const Expanded(child: Text('Bloqueados', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600))),
                const SizedBox(width: 40),
              ]),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover)),
              child: accounts.isEmpty
                  ? const Center(child: Text('No tienes cuentas bloqueadas.', style: TextStyle(color: Colors.white70, fontSize: 18)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                      itemCount: accounts.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (_, i) => _BlockedCard(account: accounts[i], onUnblock: () => _unblock(accounts[i])),
                    ),
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

class _BlockedCard extends StatelessWidget {
  final _BlockedAccount account;
  final VoidCallback onUnblock;
  const _BlockedCard({required this.account, required this.onUnblock});

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      aspectRatio: 720 / 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
        child: Row(children: [
          CircleAvatar(radius: 42, backgroundColor: account.color, child: Text(account.initial, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700))),
          const SizedBox(width: 18),
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(account.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)), Text(account.handle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 16))])),
          GestureDetector(onTap: onUnblock, child: Container(height: 34, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)), alignment: Alignment.center, child: const Text('DESBLOQUEAR', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4)))),
        ]),
      ),
    );
  }
}

class _BlockedAccount {
  final String initial;
  final String name;
  final String handle;
  final Color color;
  const _BlockedAccount(this.initial, this.name, this.handle, this.color);
}
