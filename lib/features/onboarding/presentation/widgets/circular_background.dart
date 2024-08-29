import 'package:flutter/material.dart';
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
      radius: isPortrait ? 130 : 85,
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.4),
        radius: isPortrait ? 105 : 70,
        child: CircleAvatar(
          backgroundColor: color,
          radius: isPortrait ? 80 : 55,
          child: SizedBox(
            width: isPortrait ? 90 : 60,
            child: Image.asset(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
