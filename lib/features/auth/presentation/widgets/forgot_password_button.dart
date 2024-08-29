import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'هل نسيت كلمة المرور؟',
          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
