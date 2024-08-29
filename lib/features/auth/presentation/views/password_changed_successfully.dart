import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/routes/routes.dart';

class PasswordChangedSuccessfullyView extends StatelessWidget {
  const PasswordChangedSuccessfullyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'تم تغيير كلمة المرور',
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isPortrait = orientation == Orientation.portrait;
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isPortrait ? 20 : screenWidth * 0.1,
                      vertical: screenHeight * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: isPortrait ? 120 : 80,
                          color: primaryGreen,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Text(
                          'تم تغيير كلمة المرور بنجاح!',
                          style: Styles.textStyle24.copyWith(
                            color: primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.',
                          style: Styles.textStyle16.copyWith(
                            color: secondaryPurple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.06),
                        PrimaryButton(
                          text: 'العودة إلى تسجيل الدخول',
                          color: primaryGreen,
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.login,
                              (Route<dynamic> route) => false,
                            );
                          },
                          width: double.infinity,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
