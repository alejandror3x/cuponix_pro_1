import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/dark_scaffold.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _location = true;
  bool _notifications = true;
  bool _camera = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DarkScaffold(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
        child: Column(
          children: [
            Row(
              children: [
                BackTriangle(onTap: () => context.go('/configuracion')),
                const Expanded(
                  child: Text(
                    'Permisos',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
            const SizedBox(height: 28),
            _row('Ubicación', 'Para encontrar ofertas cerca tuyo.', _location, (v) => setState(() => _location = v)),
            _row('Notificaciones', 'Para avisarte de cupones, solicitudes y mensajes.', _notifications, (v) => setState(() => _notifications = v)),
            _row('Cámara / QR', 'Para escanear códigos de cupones y canjes.', _camera, (v) => setState(() => _camera = v)),
            const Spacer(),
            Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 74),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String body, bool value, ValueChanged<bool> onChanged) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xE0555555),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(body, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.25)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            CuponixToggle(value: value, onChanged: onChanged),
          ],
        ),
      );
}
