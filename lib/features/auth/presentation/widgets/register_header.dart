import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إنشاء حساب جديد',
          style: Styles.textStyle28.copyWith(color: Colors.black),
        ),
        Text(
          'أدخل بياناتك لإنشاء حساب',
          style: Styles.textStyle16.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
