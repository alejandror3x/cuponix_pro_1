import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/cuponix_toggle.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _showInterests = false;
  final Set<String> _selected = {};

  static const _tags = [
    'Restaurante', 'Arte', 'Deporte', 'Ropa', 'Música', 'Coctel',
    'Cine', 'Hamburguesa', 'Tecnología', 'Maquillaje', 'Salud', 'Gym',
    'Mascotas', 'Vegetariano', 'Artesania', 'Pizza', 'Sushi', 'Bares',
    'Internacional', 'Bicicleta', 'Dulces',
  ];

  void _askMediaPermission() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          'Cuponix desea acceder a tu\nGalería Multimedia',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.ink, fontSize: 16),
        ),
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
          CuponixHeader(title: 'Editar Perfil', onBack: () => context.pop()),
          const SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _askMediaPermission,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.avatarGrey,
                          boxShadow: [BoxShadow(color: Color(0x59000000), blurRadius: 24, offset: Offset(0, 10))],
                        ),
                        child: const Icon(Icons.add, color: Color(0x8CFFFFFF), size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('Biografía', style: TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(color: const Color(0x8C787878), borderRadius: BorderRadius.circular(18)),
                    child: TextField(
                      maxLines: 5,
                      maxLength: 200,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        filled: false,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Color(0x80FF073A), width: 2)),
                        contentPadding: const EdgeInsets.all(14),
                        counterStyle: const TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Intereses ',
                                style: TextStyle(color: Colors.white, fontSize: 13),
                                children: [TextSpan(text: '(Opcional)', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11))],
                              ),
                            ),
                            const SizedBox(height: 6),
                            const PillTextField(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Text('Mostrar intereses\nen perfil.', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.2), textAlign: TextAlign.right),
                            const SizedBox(width: 12),
                            CuponixToggle(value: _showInterests, onChanged: (v) => setState(() => _showInterests = v)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text('Ó Escoje Intereses que te identifiquen:', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      final on = _selected.contains(tag);
                      return GestureDetector(
                        onTap: () => setState(() => on ? _selected.remove(tag) : _selected.add(tag)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: on ? AppColors.neonRed : Colors.transparent,
                            border: Border.all(color: AppColors.neonRed, width: 1.5),
                          ),
                          child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                  Center(child: PillButton(label: 'SIGUIENTE', onPressed: () => context.push('/business-profile'))),
                  const SizedBox(height: 14),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.go('/email-verification'),
                      child: const Text('USAR COMO CLIENTE', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
