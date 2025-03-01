import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/horizontal_logo.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/strings.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:selaty/features/auth/presentation/views/login_view.dart';
import 'package:selaty/features/auth/presentation/views/register_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isPortrait ? screenWidth / 9 : screenWidth / 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HorizontalLogo(),
            SizedBox(
              height: isPortrait ? 50 : 20,
            ),
            PrimaryButton(
              height: isPortrait ? screenWidth / 7 : 60,
              width: isPortrait ? double.infinity : screenWidth / 2,
              text: Strings.loginTitle,
              color: primaryRed,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<LoginCubit>(
                              create: (context) => sl<LoginCubit>(),
                              child: const LoginView(),
                            )));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              height: isPortrait ? screenWidth / 7 : 60,
              width: isPortrait ? double.infinity : screenWidth / 2,
              text: Strings.registerTitle,
              color: primaryGreen,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => sl<RegisterCubit>(),
                              child: const RegisterView(),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
