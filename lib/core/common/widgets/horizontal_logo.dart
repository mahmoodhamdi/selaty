import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/device/device_utility.dart';

class HorizontalLogo extends StatelessWidget {
  const HorizontalLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = TDeviceUtils.isLandscapeOrientation(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width / (isPortrait ? 3.5 : 7),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            const Text(
              'ســـــــــــلتي',
              style: Styles.textStyle40,
            ),
            Text(
              'S    E    L    A    T    Y',
              style: Styles.textStyle18.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
