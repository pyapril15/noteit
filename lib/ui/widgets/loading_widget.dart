import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final EdgeInsetsGeometry? padding;
  final String? text;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? strokeWidth;
  final bool useLinearProgress;

  const LoadingWidget({
    super.key,
    this.size,
    this.padding,
    this.text,
    this.textColor,
    this.textStyle,
    this.strokeWidth,
    this.useLinearProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size ?? 48.0,
              height: size ?? 48.0,
              child: useLinearProgress
                  ? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              )
                  : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
                strokeWidth: strokeWidth ?? 4.0,
              ),
            ),
            if (text != null) ...[
              const SizedBox(height: 8.0),
              Text(
                text!,
                style: textStyle ??
                    theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}