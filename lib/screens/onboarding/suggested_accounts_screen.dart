import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/ticket_card.dart';

class SuggestedAccountsScreen extends StatelessWidget {
  const SuggestedAccountsScreen({super.key});

  static const _accounts = [
    _SuggestedAccount(
      'R',
      'Rukito',
      '@rukitogrillndrinks',
      Colors.white,
      AppColors.ink,
    ),
    _SuggestedAccount(
      "Roger's",
      "Roger's Smash",
      '@rogersec',
      Color(0xFFD4322B),
      Colors.white,
    ),
    _SuggestedAccount(
      'T',
      'Tijuana',
      '@tijuanaec',
      Color(0xFFFEF9E8),
      AppColors.ink,
    ),
    _SuggestedAccount(
      'BR',
      'Baskin Robbins',
      '@baskinrobbinsec',
      Color(0xFF0B6CB1),
      Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      child: Column(
        children: [
          const Text(
            'Cuentas Sugeridas',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.separated(
              itemCount: _accounts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (_, i) => _AccountCard(account: _accounts[i]),
            ),
          ),
          const SizedBox(height: 16),
          PillButton(label: 'SIGUIENTE', onPressed: () => context.go('/home')),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final _SuggestedAccount account;

  const _AccountCard({required this.account});

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      aspectRatio: 720 / 200,
      child: LayoutBuilder(
        builder: (_, c) {
          final s = (c.maxWidth / 520.0).clamp(0.5, 1.5);
          return Padding(
            padding: EdgeInsets.fromLTRB(28 * s, 16 * s, 24 * s, 16 * s),
            child: Row(
              children: [
                Container(
                  width: 76 * s,
                  height: 76 * s,
                  decoration: BoxDecoration(
                    color: account.bg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    account.avatar,
                    style: TextStyle(
                      color: account.fg,
                      fontSize: (15 * s).clamp(8, 15),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 16 * s),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (21 * s).clamp(11, 21),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        account.handle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: (15 * s).clamp(8, 15),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10 * s),
                _pill('SEGUIR', s),
                SizedBox(width: 8 * s),
                _pill('X', s, compact: true),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _pill(String label, double s, {bool compact = false}) => Container(
    height: (34 * s).clamp(22, 34),
    width: compact ? (38 * s).clamp(26, 38) : null,
    padding: compact
        ? EdgeInsets.zero
        : EdgeInsets.symmetric(horizontal: 16 * s),
    decoration: BoxDecoration(
      color: AppColors.neonRed,
      borderRadius: BorderRadius.circular(999),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66FF073A),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: (12 * s).clamp(8, 12),
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  );
}

class _SuggestedAccount {
  final String avatar;
  final String name;
  final String handle;
  final Color bg;
  final Color fg;

  const _SuggestedAccount(
    this.avatar,
    this.name,
    this.handle,
    this.bg,
    this.fg,
  );
}
