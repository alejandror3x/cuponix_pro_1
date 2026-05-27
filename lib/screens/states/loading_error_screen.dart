import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class LoadingStateScreen extends StatelessWidget {
  const LoadingStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 92),
          const SizedBox(height: 28),
          const CircularProgressIndicator(color: AppColors.neonRed),
          const SizedBox(height: 24),
          const Text(
            'Cargando...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Estamos preparando tu experiencia.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class ErrorStateScreen extends StatelessWidget {
  final String title;
  final String body;

  const ErrorStateScreen({
    super.key,
    this.title = 'Algo salió mal',
    this.body = 'No pudimos completar la acción. Intenta nuevamente.',
  });

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: AppColors.neonRed, size: 78),
          const SizedBox(height: 22),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.3),
          ),
          const SizedBox(height: 30),
          PillButton(label: 'INTENTAR DE NUEVO', onPressed: () => context.go('/home')),
        ],
      ),
    );
  }
}
