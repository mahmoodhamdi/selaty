import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/features/auth/presentation/views/auth_view.dart';
import 'package:selaty/features/auth/presentation/views/login_view.dart';
import 'package:selaty/features/auth/presentation/views/new_password_view.dart';
import 'package:selaty/features/auth/presentation/views/otp_view.dart';
import 'package:selaty/features/auth/presentation/views/password_changed_successfully.dart';
import 'package:selaty/features/auth/presentation/views/register_view.dart';
import 'package:selaty/features/auth/presentation/views/reset_password_view.dart';
import 'package:selaty/features/home/presentation/views/home_view.dart';
import 'package:selaty/features/onboarding/presentation/views/onboarding_view.dart';

class Routes {
  static const String onBoarding = '/';
  static const String homeView = '/home_view';
  static const String login = '/login';
  static const String register = '/register';
  static const String authView = '/auth_view';
  static const String resetPassword = '/reset_password';
  static const String otpView = '/otp_view';
  static const String newPasswordView = '/new_password_view';

  static const String passwordChangedSuccessfullyView =
      '/password_changed_successfully_view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // this arguments is for passing data from one screen to another
    // final arguments = settings.arguments;

    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OnboardingCubit(),
                  child: const OnboardingView(),
                ));
      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case authView:
        return MaterialPageRoute(builder: (_) => const AuthView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case otpView:
        return MaterialPageRoute(
            builder: (_) => OtpView(email: settings.arguments as String));
      case newPasswordView:
        return MaterialPageRoute(
            builder: (_) => NewPasswordView(
                  email: settings.arguments as String,
                ));

      case passwordChangedSuccessfullyView:
        return MaterialPageRoute(
            builder: (_) => const PasswordChangedSuccessfullyView());
      default:
        // error page
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('${settings.name} not found')),
                  appBar: AppBar(title: const Text('Error')),
                ));
    }
  }
}
