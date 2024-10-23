import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/validators/validator.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.text,
    required this.width,
    required this.controller,
  });

  final String text;
  final double width;
  final TextEditingController controller;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        validator: TValidator.validatePassword,
        obscureText: !showPassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
              color: Colors.grey,
              size: 18,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
          label: Text(widget.text, style: const TextStyle(color: Colors.grey)),
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
