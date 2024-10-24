import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/views/login_view.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('لديك حساب بالفعل؟', style: Styles.textStyle16),
          TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => sl<LoginCubit>(),
                          child: const LoginView(),
                        ))),
            child: Text(
              'تسجيل الدخول',
              style: Styles.textStyle16
                  .copyWith(color: primaryGreen, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
