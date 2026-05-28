import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class StartupPermissionsScreen extends StatefulWidget {
  const StartupPermissionsScreen({super.key});

  @override
  State<StartupPermissionsScreen> createState() => _StartupPermissionsScreenState();
}

class _StartupPermissionsScreenState extends State<StartupPermissionsScreen> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      _started = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _runV1Popups());
    }
  }

  Future<void> _runV1Popups() async {
    await _permissionPopup(
      message: 'Cuponix desea enviarte\nnotificaciones.',
      allowLabel: 'Permitir',
      denyLabel: 'Ahora no',
    );
    if (!mounted) return;
    await _permissionPopup(
      message: 'Cuponix desea acceder\na tu ubicación',
      allowLabel: 'Permitir',
      denyLabel: 'Ahora no',
    );
    if (!mounted) return;
    context.go('/login');
  }

  Future<void> _permissionPopup({required String message, required String allowLabel, required String denyLabel}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(22, 24, 22, 16),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.ink, fontSize: 16, height: 1.25),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(allowLabel)),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(denyLabel)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/cuponix-imagotipo-cropped.png', width: 200, height: 200, fit: BoxFit.contain),
              const SizedBox(height: 24),
              Image.asset('assets/images/cuponix-logotipo-cropped.png', width: 260, fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}
