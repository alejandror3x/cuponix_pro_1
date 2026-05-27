import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bottom_nav_bar.dart';

class ExplorarScreen extends StatefulWidget {
  const ExplorarScreen({super.key});

  @override
  State<ExplorarScreen> createState() => _ExplorarScreenState();
}

class _ExplorarScreenState extends State<ExplorarScreen> {
  final _controller = TextEditingController();
  final Set<String> _selected = {};

  static const _categories = [
    'Restaurante', 'Arte', 'Deporte', 'Ropa', 'Música', 'Coctel',
    'Cine', 'Hamburguesa', 'Tecnología', 'Maquillaje', 'Salud', 'Gym',
    'Mascotas', 'Vegetariano', 'Artesanía', 'Pizza', 'Sushi', 'Bares',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.fromLTRB(26, 12, 26, 12),
                child: Row(children: [
                  Image.asset('assets/images/cuponix-imagotipo-cropped.png', height: 36, fit: BoxFit.contain),
                  const SizedBox(width: 8),
                  Image.asset('assets/images/cuponix-logotipo-cropped.png', height: 26, fit: BoxFit.contain),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.go('/mensajes'),
                    child: Image.asset('assets/images/icon-mensajes.png', width: 36, height: 36, fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () => context.go('/configuracion'),
                    child: Image.asset('assets/images/icon-configuracion.png', width: 36, height: 36, fit: BoxFit.contain),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFF073A),
                      Color(0xFFD81672),
                      Color(0xFFA8189A),
                      Color(0xFF6D1AA0),
                      Color(0xFF2D1078),
                    ],
                    stops: [0.0, 0.25, 0.50, 0.75, 1.0],
                  ),
                ),
                child: Stack(children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/fondo-negro.png',
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.22),
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        '¿Qué estás buscando?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600, height: 1.1),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _controller,
                        maxLines: null,
                        minLines: 4,
                        style: const TextStyle(color: Color(0xFF1C1C1C), fontSize: 15, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: Colors.white54, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: GestureDetector(
                          onTap: () => context.go('/buscar-resultados'),
                          child: Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            decoration: BoxDecoration(
                              color: AppColors.purple,
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: const [
                                BoxShadow(color: Color(0x732D1078), blurRadius: 14, offset: Offset(0, 5)),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text('BUSCAR',
                              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1.3)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Busca por categorías',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500, height: 1.1),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: _categories.map((cat) {
                          final on = _selected.contains(cat);
                          return GestureDetector(
                            onTap: () => setState(() {
                              if (on) { _selected.remove(cat); } else { _selected.add(cat); }
                            }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                              decoration: BoxDecoration(
                                color: on ? AppColors.neonRed : AppColors.black,
                                border: Border.all(color: AppColors.neonRed, width: 1.5),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(cat,
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: GestureDetector(
                          onTap: () => context.go('/buscar-resultados'),
                          child: Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            decoration: BoxDecoration(
                              color: AppColors.neonRed,
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: const [
                                BoxShadow(color: Color(0x66FF073A), blurRadius: 14, offset: Offset(0, 5)),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text('BUSCAR',
                              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1.3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            BottomNavBar(
              active: NavTab.explore,
              onTap: (t) {
                switch (t) {
                  case NavTab.home: context.go('/home');
                  case NavTab.explore: break;
                  case NavTab.cupones: context.go('/cupones');
                  case NavTab.perfil: context.go('/perfil');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
