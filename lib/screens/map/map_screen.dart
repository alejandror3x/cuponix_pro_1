import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cuponix_header.dart';
import '../../core/widgets/pill_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D4D4),
        body: Stack(
          children: [
            // Map placeholder — neutral grey, replace with real map widget later
            const Positioned.fill(
              child: ColoredBox(color: Color(0xFFD4D4D4)),
            ),

            // Floating dark header bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x59000000),
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CuponixBackButton(
                        size: 54,
                        onTap: () => context.pop(),
                      ),
                      PillButton(
                        label: 'GUARDAR',
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
