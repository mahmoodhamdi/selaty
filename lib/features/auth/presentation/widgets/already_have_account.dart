import 'package:flutter/material.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'تسجيل الدخول',
            style: Styles.textStyle16,
          ),
          GestureDetector(
            child: const Text(
              'لديك حساب بالفعل؟',
              style: Styles.textStyle16,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
