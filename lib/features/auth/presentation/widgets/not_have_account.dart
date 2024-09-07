import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/auth/presentation/views/register_view.dart';

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
          const Text('ليس لديك حساب؟', style: Styles.textStyle16),
          TextButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterView())),
            child: Text(
              'إنشاء حساب',
              style: Styles.textStyle16
                  .copyWith(color: primaryGreen, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
