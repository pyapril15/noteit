import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';

class EmailStatusWidget extends StatefulWidget {
  final User? firebaseUser;

  const EmailStatusWidget({super.key, required this.firebaseUser});

  @override
  State<EmailStatusWidget> createState() => _EmailStatusWidgetState();
}

class _EmailStatusWidgetState extends State<EmailStatusWidget> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    if (widget.firebaseUser == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          _buildIcon(theme),
          const SizedBox(width: 16),
          _buildEmailColumn(theme),
        ],
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    return Icon(Icons.email, color: theme.colorScheme.onSurface.withAlpha(153));
  }

  Widget _buildEmailColumn(ThemeData theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(theme),
          _buildEmailRow(theme),
          _buildFocusIndicator(theme),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLabel(ThemeData theme) {
    return Text(
      'Email',
      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildEmailRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: TextEditingController(
              text: widget.firebaseUser!.email ?? 'N/A',
            ),
            enabled: !widget.firebaseUser!.emailVerified,
            decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(102),
              ),
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
        const SizedBox(width: 8),
        _buildVerificationStatus(theme),
      ],
    );
  }

  Widget _buildVerificationStatus(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            widget.firebaseUser!.emailVerified
                ? AppColors.success
                : theme.colorScheme.error,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.firebaseUser!.emailVerified ? 'Verified' : 'Not Verified',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
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
