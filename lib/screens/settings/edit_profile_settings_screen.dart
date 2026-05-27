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
  State<EditProfileSettingsScreen> createState() =>
      _EditProfileSettingsScreenState();
}

class _EditProfileSettingsScreenState extends State<EditProfileSettingsScreen> {
  bool _showInterests = true;
  final Set<String> _selected = {'software', 'pc', 'mac', 'social'};

  static const _tags = [
    'Restaurante',
    'Arte',
    'Deporte',
    'Ropa',
    'Música',
    'Coctel',
    'Cine',
    'Hamburguesa',
    'Tecnología',
    'Maquillaje',
    'Salud',
    'Gym',
    'software',
    'pc',
    'mac',
    'social',
  ];

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(
            title: 'Editar Perfil',
            onBack: () => context.go('/configuracion'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push('/cargar-foto'),
                      child: Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDB38B),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x59000000),
                            blurRadius: 24,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'T',
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 46,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Biografía',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x8C787878),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const TextField(
                      maxLines: 5,
                      maxLength: 200,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Fundador de MySpace.',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14),
                        counterStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Intereses',
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            SizedBox(height: 6),
                            PillTextField(hint: 'Agregar interés'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Mostrar intereses\nen perfil.',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            CuponixToggle(
                              value: _showInterests,
                              onChanged: (v) => setState(() => _showInterests = v),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      final on = _selected.contains(tag);
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (on) {
                            _selected.remove(tag);
                          } else {
                            _selected.add(tag);
                          }
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: on ? AppColors.neonRed : Colors.transparent,
                            border: Border.all(
                              color: AppColors.neonRed,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: PillButton(
                      label: 'GUARDAR',
                      onPressed: () => context.go('/configuracion'),
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
