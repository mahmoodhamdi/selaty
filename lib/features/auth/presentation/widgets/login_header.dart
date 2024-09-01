import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/constants/colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: isPortrait ? 30.h : 20.h), // Use ScreenUtil for padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'ســـــــــــلتي',
                style: TextStyle(
                  color: accentRedText,
                  fontSize: isPortrait
                      ? 34.sp
                      : 24.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoKufiArabic',
                ),
              ),
              Text(
                'S    E    L    A    T    Y',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isPortrait
                      ? 18.sp
                      : 12.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(width: 10.h), // Use ScreenUtil for width
          Image.asset(
            'assets/images/logo.png',
            width: isPortrait ? 100.w : 50.w, // Use ScreenUtil for width
          ),
        ],
      ),
    );
  }
}
