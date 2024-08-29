import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/routes/routes.dart';

class NotHaveAccount extends StatelessWidget {
  const NotHaveAccount({
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
            onPressed: () => Navigator.pushNamed(context, Routes.register),
            child: const Text(
              'إنشاء حساب',
              style:
                  TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
            ),
          ),
          const Text('ليس لديك حساب؟', style: Styles.textStyle16),
        ],
      ),
    );
  }
}
