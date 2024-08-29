import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/device/device_utility.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = TDeviceUtils.isPortraitOrientation(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isPortrait ? 30 : 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'ســـــــــــلتي',
                style: TextStyle(
                  color: accentRedText,
                  fontSize: isPortrait ? 34 : 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoKufiArabic',
                ),
              ),
              Text(
                'S    E    L    A    T    Y',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isPortrait ? 18 : 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Image.asset(
            'assets/images/logo.png',
            width: isPortrait ? 100 : 80,
          ),
        ],
      ),
    );
  }
}
