import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cupon_scaffold.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';

class PhotoPickerScreen extends StatelessWidget {
  const PhotoPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
      child: Column(
        children: [
          Row(
            children: [
              BackTriangle(onTap: () => context.pop()),
              const Expanded(
                child: Text(
                  'Cargar Foto',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const Spacer(),
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: AppColors.avatarGrey,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 20, offset: Offset(0, 8))],
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.add_photo_alternate_outlined, color: Colors.white70, size: 82),
          ),
          const SizedBox(height: 26),
          const Text(
            'Selecciona una imagen para tu perfil, negocio o producto.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 19, height: 1.3),
          ),
          const Spacer(),
          PillButton(label: 'TOMAR FOTO', onPressed: () {}),
          const SizedBox(height: 14),
          PillButton(label: 'ELEGIR DE GALERÍA', onPressed: () {}),
        ],
      ),
    );
  }
}
