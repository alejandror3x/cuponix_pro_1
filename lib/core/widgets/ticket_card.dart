import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  const TicketClipper();

  @override
  Path getClip(Size s) {
    const cr = 14.0; // corner radius
    const nr = 11.0; // notch radius
    final my = s.height / 2;

    return Path()
      ..moveTo(cr, 0)
      ..lineTo(s.width - cr, 0)
      ..quadraticBezierTo(s.width, 0, s.width, cr)
      ..lineTo(s.width, my - nr)
      ..arcToPoint(Offset(s.width, my + nr),
          radius: const Radius.circular(nr), clockwise: false)
      ..lineTo(s.width, s.height - cr)
      ..quadraticBezierTo(s.width, s.height, s.width - cr, s.height)
      ..lineTo(cr, s.height)
      ..quadraticBezierTo(0, s.height, 0, s.height - cr)
      ..lineTo(0, my + nr)
      ..arcToPoint(Offset(0, my - nr),
          radius: const Radius.circular(nr), clockwise: false)
      ..lineTo(0, cr)
      ..quadraticBezierTo(0, 0, cr, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => false;
}

class TicketCard extends StatelessWidget {
  final double aspectRatio;
  final Widget child;
  final Color color;

  const TicketCard({
    super.key,
    this.aspectRatio = 720 / 240,
    required this.child,
    this.color = const Color(0xE0555555),
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipPath(
        clipper: const TicketClipper(),
        child: Container(color: color, child: child),
      ),
    );
  }
}
