import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/points_icon.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  void _askMediaPermission(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text('Cuponix desea acceder a tu\nGalería Multimedia', textAlign: TextAlign.center, style: TextStyle(color: AppColors.ink, fontSize: 16)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () { Navigator.of(context).pop(); context.push('/cargar-foto'); }, child: const Text('Permitir')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ahora no')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(title: 'Editar Producto', onBack: () => context.go('/editar-perfil-config')),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Nuevo Nombre de Producto /Servicio', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 5),
                const FractionallySizedBox(widthFactor: 0.68, child: PillTextField(hint: 'Smash Bacon')),
                const SizedBox(height: 10),
                GestureDetector(onTap: () => _askMediaPermission(context), child: AspectRatio(aspectRatio: 660 / 410, child: Container(decoration: BoxDecoration(color: AppColors.avatarGrey, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color(0x59000000), blurRadius: 20, offset: Offset(0, 8))]), child: const Icon(Icons.fastfood, color: Color(0xCCFFFFFF), size: 62)))),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: Column(children: [_priceInput('8.99'), const SizedBox(height: 10), const Text('Precio', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15))])),
                  const SizedBox(width: 20),
                  Expanded(child: Column(children: [
                    _priceInput('25'),
                    const SizedBox(height: 10),
                    const Row(mainAxisAlignment: MainAxisAlignment.center, children: [PointsIcon(size: 18), SizedBox(width: 5), Text('Precio en Puntos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15))]),
                    const SizedBox(height: 2),
                    GestureDetector(onTap: () => context.push('/points-help'), child: const Text('¿Qué es esto?', style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 13, decoration: TextDecoration.underline, decorationColor: Color(0xD9FFFFFF)))),
                  ])),
                ]),
                const SizedBox(height: 12),
                const Text('Descripción', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 6),
                Container(decoration: BoxDecoration(color: const Color(0xB3DCDCDC), borderRadius: BorderRadius.circular(18)), child: const TextField(maxLines: 4, maxLength: 200, style: TextStyle(color: AppColors.ink, fontSize: 13), decoration: InputDecoration(hintText: 'Burger smash con bacon, queso y cebollitas.', hintStyle: TextStyle(color: Color(0xAA2A2A2A)), border: InputBorder.none, contentPadding: EdgeInsets.all(12), counterStyle: TextStyle(color: Colors.white54)))),
                const SizedBox(height: 18),
                Center(child: PillButton(label: 'GUARDAR', onPressed: () => context.go('/editar-perfil-config'))),
                const SizedBox(height: 14),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceInput(String hint) => TextField(
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    textAlign: TextAlign.center,
    style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w500, fontSize: 13),
    decoration: InputDecoration(hintText: hint, filled: true, fillColor: AppColors.fieldBg, isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide.none)),
  );
}
