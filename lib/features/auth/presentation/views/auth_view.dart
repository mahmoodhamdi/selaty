import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/widgets/horizontal_logo.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/text_strings.dart';
import 'package:selaty/features/auth/presentation/views/login_view.dart';
import 'package:selaty/features/auth/presentation/views/register_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w, // Make horizontal padding responsive
          vertical:
              isPortrait ? 0.3.sh : 0.06.sh, // Make vertical padding responsive
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
              width: isPortrait ? double.infinity : 0.5.sw,
              text: TTexts.loginTitle,
              color: primaryRed,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
              },
            ),
            SizedBox(
              height: 16.h, // Add space between buttons, responsive
            ),
            PrimaryButton(
              width: isPortrait ? double.infinity : 0.5.sw,
              text: TTexts.registerTitle,
              color: primaryGreen,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
