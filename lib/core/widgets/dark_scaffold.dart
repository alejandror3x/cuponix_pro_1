import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class DarkScaffold extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const DarkScaffold({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(34, 28, 34, 34),
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.black,
            image: DecorationImage(
              image: AssetImage('assets/images/fondo-negro.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
