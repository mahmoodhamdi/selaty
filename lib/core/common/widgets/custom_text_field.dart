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
      required this.controller});
  final String text;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final double width;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
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
          label: Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
