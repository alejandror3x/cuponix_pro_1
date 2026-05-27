import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/pill_button.dart';

class StartupPermissionsScreen extends StatefulWidget {
  const StartupPermissionsScreen({super.key});

  @override
  State<StartupPermissionsScreen> createState() =>
      _StartupPermissionsScreenState();
}

class _StartupPermissionsScreenState extends State<StartupPermissionsScreen> {
  bool _location = true;
  bool _notifications = true;
  bool _camera = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2A1485),
                Color(0xFF6D1AA0),
                Color(0xFFD81672),
                AppColors.neonRed,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 34, 30, 34),
              child: Column(
                children: [
                  Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 92),
                  const SizedBox(height: 18),
                  const Text(
                    'Permisos',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.antique, fontSize: 36, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Activa estos accesos para que Cuponix pueda mostrar ofertas cercanas, avisos y validar códigos QR.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, height: 1.28),
                  ),
                  const SizedBox(height: 28),
                  _permission('Ubicación', _location, (v) => setState(() => _location = v)),
                  _permission('Notificaciones', _notifications, (v) => setState(() => _notifications = v)),
                  _permission('Cámara / QR', _camera, (v) => setState(() => _camera = v)),
                  const Spacer(),
                  PillButton(label: 'CONTINUAR', onPressed: () => context.go('/login')),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: const Text(
                      'AHORA NO',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _permission(String label, bool value, ValueChanged<bool> onChanged) =>
      Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.fromLTRB(18, 14, 16, 14),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.48),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            CuponixToggle(value: value, onChanged: onChanged),
          ],
        ),
      );
}
