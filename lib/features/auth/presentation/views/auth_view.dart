import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/horizontal_logo.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/sizes.dart';
import 'package:selaty/core/constants/text_strings.dart';
import 'package:selaty/core/device/device_utility.dart';
import 'package:selaty/core/routes/routes.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait = TDeviceUtils.isPortraitOrientation(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: TSizes.defaultSpace,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HorizontalLogo(),
            const SizedBox(
              height: 40,
            ),
            PrimaryButton(
              text: TTexts.loginTitle,
              color: primaryRed,
              onTap: () {
                Navigator.pushNamed(context, Routes.login);
              },
            ),
            PrimaryButton(
              text: TTexts.registerTitle,
              color: primaryGreen,
              onTap: () {
                Navigator.pushNamed(context, Routes.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
