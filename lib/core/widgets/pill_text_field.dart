import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class PillTextField extends StatelessWidget {
  final String? hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final double? letterSpacing;

  const PillTextField({
    super.key,
    this.hint,
    this.obscure = false,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      style: TextStyle(
        color: AppColors.ink,
        fontWeight: FontWeight.w500,
        fontSize: 13,
        letterSpacing: letterSpacing,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.fieldPh, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: AppColors.fieldBg,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
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
}
