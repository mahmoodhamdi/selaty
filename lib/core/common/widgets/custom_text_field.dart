import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.text,
      this.suffixIcon,
      this.isPassword = false,
      required this.width,
      this.onSaved,
      this.validator,
      this.prefixIcon,
      this.onChanged,
      required this.controller,
      required this.keyboardType});

  final String text;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final double width;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          suffixIcon: suffixIcon,
          label: Text(text, style: const TextStyle(color: Colors.grey)),
          border: _borderStyle(),
          enabledBorder: _borderStyle(),
          focusedBorder: _borderStyle(),
        ),
      ),
    );
  }

  OutlineInputBorder _borderStyle() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}
