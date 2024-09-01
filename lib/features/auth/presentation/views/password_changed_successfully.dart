import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
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

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isPortrait
                          ? 20.w
                          : 20.w, // Use ScreenUtil for horizontal padding
                      vertical: 20.h, // Use ScreenUtil for vertical padding
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: isPortrait
                              ? 120.w
                              : 80.w, // Use ScreenUtil for icon size
                          color: primaryGreen,
                        ),
                        SizedBox(height: 20.h), // Use ScreenUtil for spacing
                        Text(
                          'تم تغيير كلمة المرور بنجاح!',
                          style: Styles.textStyle24.copyWith(
                            color: primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h), // Use ScreenUtil for spacing
                        Text(
                          'يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.',
                          style: Styles.textStyle16.copyWith(
                            color: secondaryPurple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h), // Use ScreenUtil for spacing
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
