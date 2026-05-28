import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _ratings = true;
  bool _reviews = true;
  bool _notifications = true;
  bool _followers = true;
  bool _shareActivity = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DarkScaffold(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
        child: Column(children: [
          Row(children: [
            BackTriangle(onTap: () => context.go('/configuracion')),
            const Expanded(child: Text('Permisos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600))),
            const SizedBox(width: 40),
          ]),
          const SizedBox(height: 28),
          _row('Permitir Valoraciones', _ratings, (v) => setState(() => _ratings = v)),
          _row('Permitir Reseñas', _reviews, (v) => setState(() => _reviews = v)),
          _row('Permitir Notificaciones', _notifications, (v) => setState(() => _notifications = v)),
          _row('Permitir Seguidores', _followers, (v) => setState(() => _followers = v)),
          _row('Permitir Compartir Actividad', _shareActivity, (v) => setState(() => _shareActivity = v)),
          const Spacer(),
          PillButton(label: 'GUARDAR', onPressed: () => context.go('/configuracion')),
          const SizedBox(height: 16),
          GestureDetector(onTap: () => context.go('/configuracion'), child: const Text('REGRESAR', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1))),
        ]),
      ),
    );
  }

  Widget _row(String title, bool value, ValueChanged<bool> onChanged) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
    decoration: BoxDecoration(color: const Color(0xE0555555), borderRadius: BorderRadius.circular(18)),
    child: Row(children: [
      Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))),
      const SizedBox(width: 14),
      CuponixToggle(value: value, onChanged: onChanged),
    ]),
  );
}
