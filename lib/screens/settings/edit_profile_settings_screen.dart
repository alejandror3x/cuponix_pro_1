import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class EditProfileSettingsScreen extends StatefulWidget {
  const EditProfileSettingsScreen({super.key});

  @override
  State<EditProfileSettingsScreen> createState() => _EditProfileSettingsScreenState();
}

class _EditProfileSettingsScreenState extends State<EditProfileSettingsScreen> {
  bool _showInterests = true;
  bool _cash = true;
  bool _card = true;
  bool _transfer = true;
  bool _ratings = true;
  final Set<String> _selected = {'software', 'pc', 'mac', 'social'};

  static const _tags = ['Restaurante', 'Arte', 'Deporte', 'Ropa', 'Música', 'Coctel', 'Cine', 'Hamburguesa', 'Tecnología', 'Maquillaje', 'Salud', 'Gym', 'software', 'pc', 'mac', 'social'];

  void _askMediaPermission() {
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

  void _askLocation() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text('Cuponix desea acceder a tu\nubicación', textAlign: TextAlign.center, style: TextStyle(color: AppColors.ink, fontSize: 16)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () { Navigator.of(context).pop(); context.push('/map-business-setup'); }, child: const Text('Permitir')),
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
          CuponixHeader(title: 'Editar Perfil', onBack: () => context.go('/configuracion')),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _section('Perfil personal'),
                Center(
                  child: GestureDetector(
                    onTap: _askMediaPermission,
                    child: Container(width: 130, height: 130, decoration: const BoxDecoration(color: Color(0xFFCDB38B), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x59000000), blurRadius: 24, offset: Offset(0, 10))]), alignment: Alignment.center, child: const Text('T', style: TextStyle(color: AppColors.ink, fontSize: 46, fontWeight: FontWeight.w700))),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Biografía', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 6),
                _bioBox(),
                const SizedBox(height: 14),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Agregar Interés:', style: TextStyle(color: Colors.white, fontSize: 13)), SizedBox(height: 6), PillTextField(hint: 'Agregar interés') ])),
                  const SizedBox(width: 16),
                  Row(children: [const Text('Mostrar intereses\nen perfil.', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 13, height: 1.2)), const SizedBox(width: 12), CuponixToggle(value: _showInterests, onChanged: (v) => setState(() => _showInterests = v))]),
                ]),
                const SizedBox(height: 14),
                const Text('Tus intereses:', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: _tags.map((tag) {
                  final on = _selected.contains(tag);
                  return GestureDetector(onTap: () => setState(() => on ? _selected.remove(tag) : _selected.add(tag)), child: AnimatedContainer(duration: const Duration(milliseconds: 150), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: on ? AppColors.neonRed : Colors.transparent, border: Border.all(color: AppColors.neonRed, width: 1.5), borderRadius: BorderRadius.circular(999)), child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500))));
                }).toList()),
                const SizedBox(height: 24),
                _section('Perfil de negocio'),
                const Text('Tipo de Negocio', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 6),
                const FractionallySizedBox(widthFactor: 0.72, child: PillTextField(hint: 'Restaurante')),
                const SizedBox(height: 12),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Dirección', style: TextStyle(color: Colors.white, fontSize: 13)), SizedBox(height: 6), PillTextField(hint: 'Av. Principal') ])),
                  const SizedBox(width: 12),
                  PillButton(label: 'UBICAR EN MAPA', variant: PillButtonVariant.small, onPressed: _askLocation),
                ]),
                const SizedBox(height: 16),
                const Text('Aceptas pagos en:', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(children: [Expanded(child: _pay('Efectivo', _cash, (v) => setState(() => _cash = v))), Expanded(child: _pay('Tarjeta', _card, (v) => setState(() => _card = v))), Expanded(child: _pay('Transferencia', _transfer, (v) => setState(() => _transfer = v)))]),
                const SizedBox(height: 12),
                Row(children: [const Expanded(child: Text('Permitir Calificaciones\ny comentarios.', style: TextStyle(color: Colors.white, fontSize: 15, height: 1.25))), CuponixToggle(value: _ratings, onChanged: (v) => setState(() => _ratings = v))]),
                const SizedBox(height: 20),
                _section('Productos /Servicios'),
                GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 200 / 240), itemCount: 3, itemBuilder: (_, i) => GestureDetector(onTap: () => context.go('/editar-producto'), child: Container(decoration: BoxDecoration(color: AppColors.avatarGrey, borderRadius: BorderRadius.circular(14), boxShadow: const [BoxShadow(color: Color(0x4D000000), blurRadius: 14, offset: Offset(0, 6))]), child: Icon(i == 0 ? Icons.fastfood : Icons.add, color: const Color(0xCCFFFFFF), size: 34)))),
                const SizedBox(height: 28),
                Center(child: PillButton(label: 'GUARDAR', onPressed: () => context.go('/configuracion'))),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String text) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)));
  Widget _bioBox() => Container(decoration: BoxDecoration(color: const Color(0x8C787878), borderRadius: BorderRadius.circular(18)), child: const TextField(maxLines: 5, maxLength: 200, style: TextStyle(color: Colors.white, fontSize: 13), decoration: InputDecoration(hintText: 'Fundador de MySpace.', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none, contentPadding: EdgeInsets.all(14), counterStyle: TextStyle(color: Colors.white54))));
  Widget _pay(String label, bool value, ValueChanged<bool> onChanged) => GestureDetector(onTap: () => onChanged(!value), child: Column(children: [CuponixToggle(value: value, onChanged: onChanged, size: 28), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 13))]));
}
