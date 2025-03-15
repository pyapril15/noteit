import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DOBPickerWidget extends StatefulWidget {
  final TextEditingController controller;

  const DOBPickerWidget({super.key, required this.controller});

  @override
  State<DOBPickerWidget> createState() => _DOBPickerWidgetState();
}

class _DOBPickerWidgetState extends State<DOBPickerWidget> {
  bool _isFocused = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    try {
      if (widget.controller.text.isNotEmpty) {
        initialDate = DateFormat('yyyy-MM-dd').parse(widget.controller.text);
      }
    } catch (e) {
      // Handle parsing error, keep initialDate as DateTime.now()
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

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
    return Icon(
      Icons.calendar_today,
      color: theme.colorScheme.onSurface.withAlpha(153),
    );
  }

  Widget _buildTextFieldColumn(ThemeData theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(theme),
          _buildDatePickerRow(theme),
          _buildFocusIndicator(theme),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLabel(ThemeData theme) {
    return Text(
      'Date of Birth',
      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDatePickerRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Select Date of Birth',
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(102),
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            style: theme.textTheme.bodyMedium,
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
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ],
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
