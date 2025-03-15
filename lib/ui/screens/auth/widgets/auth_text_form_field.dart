import 'package:flutter/material.dart';

/// A customizable TextFormField widget commonly used in authentication forms.
///
/// This widget simplifies the creation of a styled and functional
/// TextFormField with optional validation, styling, and obscured text input.
///
/// Example Usage:
/// ```dart
/// AuthTextFormField(
///   controller: TextEditingController(),
///   decoration: InputDecoration(
///     labelText: 'Email',
///     border: OutlineInputBorder(),
///   ),
///   validator: (value) {
///     if (value == null || value.isEmpty) {
///       return 'Please enter your email';
///     }
///     return null;
///   },
/// );
/// ```
///
/// Parameters:
/// - [controller]: The TextEditingController to manage the input text. (Required)
/// - [decoration]: InputDecoration to style the input field. Defaults to an empty InputDecoration.
/// - [style]: TextStyle for the input text. If null, defaults to the theme's `displayLarge` style.
/// - [validator]: A function to validate the input text. Returns a string with the error message or null if valid.
/// - [obscureText]: A boolean indicating whether the input should be obscured. Defaults to false.
///
/// This widget is stateless and does not manage its own state.
/// For more complex behavior, consider extending it as a StatefulWidget.

class AuthTextFormField extends StatelessWidget {
  /// The controller to manage the text entered into this field.
  final TextEditingController controller;

  /// The decoration used to style the TextFormField.
  final InputDecoration decoration;

  /// The style for the input text.
  final TextStyle? style;

  /// An optional validation function.
  final String? Function(String?)? validator;

  /// Whether to obscure the input text (e.g., for passwords).
  final bool obscureText;

  /// Creates an AuthTextFormField widget.
  const AuthTextFormField({
    super.key,
    required this.controller,
    this.decoration = const InputDecoration(),
    this.style,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
      decoration: decoration,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
