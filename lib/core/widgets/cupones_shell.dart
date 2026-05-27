import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import 'bottom_nav_bar.dart';

// ---------------------------------------------------------------------------
// Shell compartida para Mis Cupones / Guardados / Solicitudes / Historial
// Header: mensajes + config icons (right-aligned)
// Inner tabs: 3 icon tabs
// ---------------------------------------------------------------------------

enum InnerTab { cupones, guardados, solicitudes }

class CuponesShell extends StatelessWidget {
  final InnerTab activeInner;
  final void Function(InnerTab) onInnerTab;
  final NavTab activeNav;
  final void Function(NavTab) onNav;
  final Widget feed;

  const CuponesShell({
    super.key,
    required this.activeInner,
    required this.onInnerTab,
    required this.activeNav,
    required this.onNav,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            // Header
            SafeArea(
              bottom: false,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.fromLTRB(26, 14, 26, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _iconBtn('assets/images/icon-mensajes.png'),
                    const SizedBox(width: 14),
                    _iconBtn('assets/images/icon-configuracion.png'),
                  ],
                ),
              ),
            ),
            // Inner tabs
            Container(
              color: AppColors.black,
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
              child: Row(
                children: [
                  _tab(InnerTab.cupones,     'tab-crearcupon'),
                  _tab(InnerTab.guardados,   'tab-guardados'),
                  _tab(InnerTab.solicitudes, 'tab-solicitudes'),
                ],
              ),
            ),
            // Scrollable content
            Expanded(child: feed),
            BottomNavBar(active: activeNav, onTap: onNav),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(String asset) => SizedBox(
    width: 36, height: 36,
    child: Image.asset(asset, fit: BoxFit.contain),
  );

  Widget _tab(InnerTab tab, String key) {
    final on = activeInner == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onInnerTab(tab),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Center(
            child: Image.asset(
              'assets/images/$key-${on ? 'activado' : 'desactivado'}.png',
              width: 50, height: 50, fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section title (right-aligned, big)
// ---------------------------------------------------------------------------
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 18, 26, 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-tabs (2-column: e.g. Cupones/Puntos, Recibidas/Enviadas)
// ---------------------------------------------------------------------------
class SubTabBar extends StatelessWidget {
  final List<String> labels;
  final int active;
  final void Function(int) onTap;

  const SubTabBar({super.key, required this.labels, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(labels.length, (i) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 14),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: active == i ? Colors.white : Colors.white60,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Stack(
          children: [
            Container(height: 1, color: Colors.white24),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: active == 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 1 / labels.length,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.neonRed,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
