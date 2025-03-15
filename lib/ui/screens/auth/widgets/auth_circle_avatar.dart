import 'package:flutter/material.dart';

class AuthCircleAvatar extends StatelessWidget {
  final Widget? child;
  final double? radius;
  final Color? backgroundColor;

  const AuthCircleAvatar({
    super.key,
    this.child,
    this.radius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      radius: radius ?? 40,
      backgroundColor:
          backgroundColor ?? theme.colorScheme.primary.withAlpha(51),
      child:
          child ??
          Icon(
            Icons.person,
            size: (radius ?? 40) * 0.8,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
    );
  }
}
