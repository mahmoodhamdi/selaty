import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final IconData prefixIcon;
  final String? Function(String?) validator;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.enabled,
    required this.prefixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? primaryBlue : Colors.grey,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: enabled ? primaryBlue : Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryBlue.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentRedText),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[50],
      ),
    );
  }
}
