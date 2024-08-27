import 'package:flutter/material.dart';
import 'package:selaty/core/routes/routes.dart';

class Selaty extends StatelessWidget {
  const Selaty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Selaty',
      initialRoute: Routes.onBoarding,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
    );
  }
}
