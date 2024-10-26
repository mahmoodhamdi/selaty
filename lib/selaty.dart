import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/config/config.dart';
import 'package:selaty/core/constants/strings.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/theme/app_theme.dart';
import 'package:selaty/features/auth/presentation/logic/login_status/login_status_cubit.dart';
import 'package:selaty/splash/views/splash_view.dart';

class Selaty extends StatelessWidget {
  const Selaty({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Config.designSize, // Define your design size here
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          title: Strings.appTitle,
          locale: Config.locale,
          localizationsDelegates: Config.localizationsDelegates,
          supportedLocales: Config.supportedLocales,
          builder: Config.builder,
          home: BlocProvider(
            create: (context) => sl<LoginStatusCubit>(),
            child: const SplashView(),
          ),
        );
      },
    );
  }
}
