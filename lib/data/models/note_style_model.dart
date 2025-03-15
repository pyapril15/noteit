// lib/data/models/note_style_model.dart
import 'package:flutter/material.dart';

class NoteStyleModel {
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextDecoration decoration;
  final double? fontSize;
  final int? color;
  final String? fontFamily;
  final TextAlign textAlign;

  NoteStyleModel({
    required this.fontWeight,
    required this.fontStyle,
    required this.decoration,
    this.fontSize,
    this.color,
    this.fontFamily,
    required this.textAlign,
  });

  Map<String, dynamic> toJson() {
    return {
      'fontWeight': fontWeight == FontWeight.bold ? 'bold' : 'normal',
      'fontStyle': fontStyle == FontStyle.italic ? 'italic' : 'normal',
      'decoration':
      decoration == TextDecoration.underline ? 'underline' : 'none',
      'fontSize': fontSize,
      'color': color,
      'fontFamily': fontFamily,
      'textAlign': textAlign.index,
    };
  }

  factory NoteStyleModel.fromJson(Map<String, dynamic> json) {
    return NoteStyleModel(
      fontWeight:
      json['fontWeight'] == 'bold' ? FontWeight.bold : FontWeight.normal,
      fontStyle:
      json['fontStyle'] == 'italic' ? FontStyle.italic : FontStyle.normal,
      decoration:
      json['decoration'] == 'underline'
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: json['fontSize'],
      color: json['color'],
      fontFamily: json['fontFamily'],
      textAlign: TextAlign.values[json['textAlign']],
    );
  }
}