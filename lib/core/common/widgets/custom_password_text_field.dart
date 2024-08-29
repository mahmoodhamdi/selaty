import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/validators/validator.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  const CustomPasswordTextFormField({
    super.key,
    required this.text,
    required this.width,
    required this.controller,
  });

  final String text;
  final double width;

  final TextEditingController controller;

  @override
  State<CustomPasswordTextFormField> createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          return TValidator.validatePassword(value);
        },
        obscureText: !showPassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          suffixIcon: IconButton(
            icon: !showPassword
                ? const Icon(
                    FontAwesomeIcons.eye,
                    color: Colors.grey,
                    size: 18,
                  )
                : const Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: Colors.grey,
                    size: 18,
                  ),
            onPressed: () {
              debugPrint(showPassword.toString());

              if (showPassword == true) {
                showPassword = false;
              } else {
                showPassword = true;
              }

              setState(() {});
              debugPrint(showPassword.toString());
            },
          ),
          label: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: const OutlineInputBorder(
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
