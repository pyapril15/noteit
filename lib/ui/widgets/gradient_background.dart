// lib/ui/widgets/gradient_background.dart
import 'package:flutter/material.dart';
import 'package:noteit/utils/constants.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;

  const GradientBackground({super.key, required this.child, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppConstants.appGradients.authGradient(),
      ),
      child: child,
    );
  }
}
