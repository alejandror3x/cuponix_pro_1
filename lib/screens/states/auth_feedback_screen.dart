import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class AuthFeedbackScreen extends StatelessWidget {
  final String title;
  final String body;
  final String action;
  final String route;

  const AuthFeedbackScreen({
    super.key,
    required this.title,
    required this.body,
    required this.action,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 82),
          const SizedBox(height: 24),
          const Icon(Icons.lock_outline, color: AppColors.neonRed, size: 64),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.3),
          ),
          const SizedBox(height: 30),
          PillButton(label: action, onPressed: () => context.go(route)),
        ],
      ),
    );
  }
}
