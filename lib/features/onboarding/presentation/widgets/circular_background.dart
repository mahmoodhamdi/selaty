import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/device/device_utility.dart';

class CircularBackground extends StatelessWidget {
  const CircularBackground({
    super.key,
    required this.color,
    required this.image,
    required this.size,
  });

  final double size;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    final isPortrait = TDeviceUtils.isLandscapeOrientation(context);

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      radius: isPortrait ? 130.r : 85.r, // Make radius responsive
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.4),
        radius: isPortrait ? 105.r : 70.r, // Make radius responsive
        child: CircleAvatar(
          backgroundColor: color,
          radius: isPortrait ? 80.r : 55.r, // Make radius responsive
          child: SizedBox(
            width: isPortrait ? 90.r : 60.r, // Make width responsive
            child: Image.asset(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
