import 'package:flutter/material.dart';

String? validateCharactersOnly(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required.';
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Only characters are allowed.';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  ).hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(
  String? value, {
  int minLength = 6,
  bool requireUppercase = true,
  bool requireLowercase = true,
  bool requireDigit = true,
  bool requireSpecialChar = true,
}) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  if (value.length < minLength) {
    return 'at least $minLength characters';
  }

  if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
    return 'at least one uppercase letter';
  }

  if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
    return 'at least one lowercase letter';
  }

  if (requireDigit && !RegExp(r'[0-9]').hasMatch(value)) {
    return 'at least one number';
  }

  if (requireSpecialChar &&
      !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'at least one special character';
  }

  return null;
}

String? validateConfirmPassword(
  String? value,
  TextEditingController passwordController,
) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }

  if (value != passwordController.text) {
    return 'Passwords do not match';
  }

  return null;
}
