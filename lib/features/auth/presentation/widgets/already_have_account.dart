import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/routes/routes.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, Routes.login),
            child: const Text(
              'تسجيل الدخول',
              style:
                  TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
            ),
          ),
          const Text('لديك حساب بالفعل؟', style: Styles.textStyle16),
        ],
      ),
    );
  }
}