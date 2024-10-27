import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/views/login_view.dart';

class PasswordChangedSuccessfullyView extends StatelessWidget {
  const PasswordChangedSuccessfullyView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Responsive sizing
    final horizontalPadding = size.width * 0.05;
    final verticalPadding = size.height * 0.03;
    final iconSize = size.width * (isPortrait ? 0.3 : 0.15);
    final spacing = size.height * 0.02;
    final largeSpacing = size.height * 0.04;

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'تم تغيير كلمة المرور',
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: iconSize,
                color: primaryGreen,
              ),
              SizedBox(height: spacing),
              Text(
                'تم تغيير كلمة المرور بنجاح!',
                style: Styles.textStyle24.copyWith(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing * 0.5),
              Text(
                'يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.',
                style: Styles.textStyle16.copyWith(
                  color: secondaryPurple,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: largeSpacing),
              PrimaryButton(
                text: 'العودة إلى تسجيل الدخول',
                color: primaryGreen,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => sl<LoginCubit>(),
                              child: const LoginView(),
                            )),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
