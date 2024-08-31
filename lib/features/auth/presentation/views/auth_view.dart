import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/widgets/horizontal_logo.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/text_strings.dart';
import 'package:selaty/core/routes/routes.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w, // Make horizontal padding responsive
          vertical: 0.3.sh, // Make vertical padding responsive
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HorizontalLogo(),
            SizedBox(
              height: 40.h, // Make space between widgets responsive
            ),
            PrimaryButton(
              text: TTexts.loginTitle,
              color: primaryRed,
              onTap: () {
                Navigator.pushNamed(context, Routes.login);
              },
            ),
            SizedBox(
              height: 16.h, // Add space between buttons, responsive
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
