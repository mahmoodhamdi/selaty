import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class HorizontalLogo extends StatelessWidget {
  const HorizontalLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo image with responsive width
        Image.asset(
          'assets/images/logo.png',
          width: screenWidth *
              (isPortrait
                  ? 0.25
                  : 0.15), // Width is a percentage of screen width
        ),
        SizedBox(
          width: screenWidth *
              0.02, // Spacing is a small percentage of screen width
        ),
        Column(
          children: [
            // Title with responsive font size
            Text(
              'ســـــــــــلتي',
              style: Styles.textStyle40.copyWith(
                fontSize: screenWidth *
                    (isPortrait
                        ? 0.09
                        : 0.06), // Font size is a percentage of screen width
              ),
            ),
            // Subtitle with responsive font size
            Text(
              'S    E    L    A    T    Y',
              style: Styles.textStyle18.copyWith(
                fontSize: screenWidth *
                    (isPortrait
                        ? 0.045
                        : 0.035), // Font size is a percentage of screen width
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
