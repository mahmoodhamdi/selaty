import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/routes/routes.dart';

class Selaty extends StatelessWidget {
  const Selaty({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Define your design size here
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Selaty',
          locale: const Locale('ar'), // Set default locale to Arabic if needed
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('ar', ''), // Arabic
          ],
          builder: (context, child) {
            // Automatically set text direction based on locale
            return Directionality(
              textDirection:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              child: child!,
            );
          },
          initialRoute: Routes.onBoarding,
          onGenerateRoute: Routes.generateRoute,
          theme: ThemeData(
            fontFamily: 'Cairo',
          ),
        );
      },
    );
  }
}
