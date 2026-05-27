import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import 'bottom_nav_bar.dart';
import 'points_icon.dart';

// ---------------------------------------------------------------------------
// CuponScaffold — full-screen layout with fondo-cupon.png card
// ---------------------------------------------------------------------------
class CuponScaffold extends StatelessWidget {
  final Widget card;
  final NavTab activeTab;
  final void Function(NavTab) onNav;

  const CuponScaffold({
    super.key,
    required this.card,
    required this.activeTab,
    required this.onNav,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fondo-cupon.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: card,
                ),
              ),
              BottomNavBar(active: activeTab, onTap: onNav),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared cupon-card components
// ---------------------------------------------------------------------------
class CuponAvatar extends StatelessWidget {
  final Color bg;
  final Color fg;
  final String label;
  final double size;

  const CuponAvatar({
    super.key,
    required this.bg,
    this.fg = Colors.white,
    required this.label,
    this.size = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.24,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class CuponProfile extends StatelessWidget {
  final Widget avatar;
  final String name;
  final String handle;

  const CuponProfile({super.key, required this.avatar, required this.name, required this.handle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        avatar,
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(handle, style: const TextStyle(color: Colors.white70, fontSize: 16)),
      ],
    );
  }
}

class CuponStatBlock extends StatelessWidget {
  final String value;
  final String label;
  final bool isPoints;

  const CuponStatBlock({super.key, required this.value, required this.label, this.isPoints = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isPoints) ...[
              const PointsIcon(size: 28),
              const SizedBox(width: 6),
            ],
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)),
          ],
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ],
    );
  }
}

class CuponCta extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const CuponCta({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 38),
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [BoxShadow(color: Color(0x732D1078), blurRadius: 14, offset: Offset(0, 5))],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 1.3,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Back-pointing triangle button (neon red)
// ---------------------------------------------------------------------------
class BackTriangle extends StatelessWidget {
  final VoidCallback onTap;
  const BackTriangle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 40, height: 40,
        child: CustomPaint(painter: _BackTrianglePainter()),
      ),
    );
  }
}

class _BackTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    canvas.drawPath(
      Path()
        ..moveTo(s.width * 0.74, s.height * 0.16)
        ..lineTo(s.width * 0.26, s.height * 0.50)
        ..lineTo(s.width * 0.74, s.height * 0.84)
        ..close(),
      Paint()..color = AppColors.neonRed..style = PaintingStyle.fill,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ---------------------------------------------------------------------------
// Title row: back triangle + centered title (used in cupon card screens)
// ---------------------------------------------------------------------------
class CuponTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const CuponTitleRow({super.key, required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackTriangle(onTap: onBack),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700, height: 1.1),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Lead text (e.g. "¡Desea Usar tu Cupón!")
// ---------------------------------------------------------------------------
class CuponLead extends StatelessWidget {
  final String text;
  const CuponLead(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500, height: 1.25),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Large centered stat (value + optional label) for cupon card screens
// ---------------------------------------------------------------------------
class CuponStatCentered extends StatelessWidget {
  final String value;
  final String label;
  final bool isPoints;

  const CuponStatCentered({super.key, required this.value, this.label = '', this.isPoints = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isPoints) ...[const PointsIcon(size: 30), const SizedBox(width: 6)],
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600)),
            ],
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Help paragraph text
// ---------------------------------------------------------------------------
class CuponHelpText extends StatelessWidget {
  final String text;
  const CuponHelpText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.3),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Expiry date label
// ---------------------------------------------------------------------------
class CuponExpiraText extends StatelessWidget {
  final String date;
  const CuponExpiraText(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Expira: $date',
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 13),
    );
  }
}

// ---------------------------------------------------------------------------
// Product mini card (photo placeholder + name + optional Ver button)
// ---------------------------------------------------------------------------
class CuponProductCard extends StatelessWidget {
  final String name;
  final bool showVerButton;

  const CuponProductCard({super.key, required this.name, this.showVerButton = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Center(
        child: SizedBox(
          width: 180,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 14, offset: Offset(0, 4))],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8D8D8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF1C1C1C), fontSize: 15, fontWeight: FontWeight.w500, height: 1.15),
                ),
                if (showVerButton) ...[
                  const SizedBox(height: 8),
                  Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                      color: AppColors.neonRed,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [BoxShadow(color: Color(0x66FF073A), blurRadius: 8, offset: Offset(0, 3))],
                    ),
                    alignment: Alignment.center,
                    child: const Text('Ver', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
