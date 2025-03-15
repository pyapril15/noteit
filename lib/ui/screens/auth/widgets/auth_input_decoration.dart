import 'package:flutter/material.dart';

InputDecoration authInputDecoration({
  String? hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
    hintText: hintText ?? 'Enter text',
    fillColor: Colors.transparent,
  );
}
