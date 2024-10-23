import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordConfirmField extends StatefulWidget {
  const PasswordConfirmField({
    super.key,
    required this.text,
    required this.width,
    required this.controller,
    required this.validator,
  });

  final String text;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  State<PasswordConfirmField> createState() => _PasswordConfirmFieldState();
}

class _PasswordConfirmFieldState extends State<PasswordConfirmField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
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
