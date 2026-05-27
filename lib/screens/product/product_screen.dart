import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/dark_scaffold.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/pill_text_field.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuponixHeader(
            title: 'Producto /Servicio',
            onBack: () => context.pop(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre de Producto /Servicio',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  const FractionallySizedBox(
                    widthFactor: 0.6,
                    child: PillTextField(),
                  ),
                  const SizedBox(height: 8),

                  // Photo placeholder
                  GestureDetector(
                    onTap: () => context.push('/cargar-foto'),
                    child: AspectRatio(
                      aspectRatio: 660 / 410,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.avatarGrey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59000000),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0x8CFFFFFF),
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Precio row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _priceInput(),
                            const SizedBox(height: 10),
                            const Text(
                              'Precio',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            _priceInput(),
                            const SizedBox(height: 10),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                text: 'Precio en Puntos  ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: '(Opcional)',
                                    style: TextStyle(
                                      color: Color(0xBFFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            GestureDetector(
                              onTap: () => context.push('/points-help'),
                              child: const Text(
                                '¿Qué es esto?',
                                style: TextStyle(
                                  color: Color(0xD9FFFFFF),
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xD9FFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Descripción
                  const Text(
                    'Descripción',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xB3DCDCDC),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: TextField(
                      maxLines: 4,
                      maxLength: 200,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0x80FF073A),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        counterStyle:
                            const TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Center(
                    child: PillButton(
                      label: 'GUARDAR',
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceInput() => TextField(
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: AppColors.ink,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.fieldBg,
      isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(999),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(999),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(999),
        borderSide: const BorderSide(color: Color(0x80FF073A), width: 2),
      ),
    ),
  );
}
