import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/routes/routes.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PrimaryButton(
        text: 'الدفع',
        color: primaryGreen,
        onTap: () => Navigator.pushNamed(context, Routes.addressView),
        width: double.infinity,
      ),
    );
  }
}