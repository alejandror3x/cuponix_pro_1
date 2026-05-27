import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum PillButtonVariant { primary, secondary, small }

class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PillButtonVariant variant;

  const PillButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = PillButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: _container(),
    );
  }

  Widget _container() {
    switch (variant) {
      case PillButtonVariant.primary:
        return _pill(
          color: AppColors.neonRed,
          height: 40,
          fontSize: 13,
          hPad: 28,
          shadow: const Color(0x66FF073A),
          blurRadius: 18,
          offset: const Offset(0, 6),
        );
      case PillButtonVariant.secondary:
        return _pill(
          color: AppColors.purple,
          height: 44,
          fontSize: 13,
          hPad: 42,
          shadow: const Color(0x732D1078),
          blurRadius: 16,
          offset: const Offset(0, 6),
        );
      case PillButtonVariant.small:
        return _pill(
          color: AppColors.neonRed,
          height: 34,
          fontSize: 11,
          hPad: 18,
          shadow: const Color(0x59FF073A),
          blurRadius: 12,
          offset: const Offset(0, 4),
        );
    }
  }

  Widget _pill({
    required Color color,
    required double height,
    required double fontSize,
    required double hPad,
    required Color shadow,
    required double blurRadius,
    required Offset offset,
  }) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(color: shadow, blurRadius: blurRadius, offset: offset),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          letterSpacing: fontSize * 0.06,
        ),
      ),
    );
  }
}
