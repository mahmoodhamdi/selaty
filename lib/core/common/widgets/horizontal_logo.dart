import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/constants/styles.dart';

class HorizontalLogo extends StatelessWidget {
  const HorizontalLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: isPortrait ? 100.w : 80.w, // Use ScreenUtil for width
        ),
        SizedBox(
          width: 10.h, // Use ScreenUtil for spacing
        ),
        Column(
          children: [
            Text(
              'ســـــــــــلتي',
              style: Styles.textStyle40.copyWith(
                fontSize: isPortrait
                    ? 36.sp
                    : 24.sp, // Ensure text style uses ScreenUtil
              ),
            ),
            Text(
              'S    E    L    A    T    Y',
              style: Styles.textStyle18.copyWith(
                fontSize: isPortrait
                    ? 18.sp
                    : 14.sp, // Ensure text style uses ScreenUtil
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
