import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailRowWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool autofocus;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const DetailRowWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.autofocus = false,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  State<DetailRowWidget> createState() => _DetailRowWidgetState();
}

class _DetailRowWidgetState extends State<DetailRowWidget> {
  String? _errorMessage;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          _buildIcon(theme),
          const SizedBox(width: 16),
          _buildTextFieldColumn(theme),
        ],
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    return Icon(widget.icon, color: theme.colorScheme.onSurface.withAlpha(153));
  }

  Widget _buildTextFieldColumn(ThemeData theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(theme),
          _buildTextField(theme),
          _buildFocusIndicator(theme),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLabel(ThemeData theme) {
    return Text(
      widget.label,
      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField(ThemeData theme) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: 'Enter ${widget.label}',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(102),
        ),
        errorText: _errorMessage,
        errorStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.error,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        filled: false,
      ),
      onChanged: (value) {
        setState(() {
          _errorMessage =
              widget.validator != null ? widget.validator!(value) : null;
        });
      },
      onTap: () {
        setState(() {
          _isFocused = true;
        });
      },
      onEditingComplete: () {
        setState(() {
          _isFocused = false;
        });
      },
      style: theme.textTheme.bodyMedium,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
    );
  }

  Widget _buildFocusIndicator(ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 1,
      color:
          _isFocused
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withAlpha(26),
    );
  }
}
