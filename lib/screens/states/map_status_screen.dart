import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class MapLoadingScreen extends StatelessWidget {
  const MapLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapStatus(
      title: 'Cargando mapa',
      body: 'Buscando ubicación y negocios cercanos.',
      loading: true,
    );
  }
}

class MapErrorScreen extends StatelessWidget {
  const MapErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapStatus(
      title: 'Mapa no disponible',
      body: 'No pudimos cargar el mapa. Revisa permisos o conexión.',
      loading: false,
    );
  }
}

class _MapStatus extends StatelessWidget {
  final String title;
  final String body;
  final bool loading;

  const _MapStatus({required this.title, required this.body, required this.loading});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(loading ? Icons.map_outlined : Icons.location_off_outlined, color: AppColors.neonRed, size: 82),
          const SizedBox(height: 22),
          if (loading) const CircularProgressIndicator(color: AppColors.neonRed),
          if (loading) const SizedBox(height: 22),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(body, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.3)),
          const SizedBox(height: 30),
          PillButton(label: loading ? 'VOLVER' : 'INTENTAR DE NUEVO', onPressed: () => context.go('/configuracion')),
        ],
      ),
    );
  }
}
