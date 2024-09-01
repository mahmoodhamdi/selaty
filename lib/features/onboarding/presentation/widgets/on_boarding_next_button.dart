import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/device/device_utility.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;

    return Positioned(
      bottom: (TDeviceUtils.getBottomNavigationBarHeight() + 25)
          .h, // Make bottom position responsive
      left: 24.w, // Make left position responsive
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: primaryGreen,
          padding: EdgeInsets.all(12.h), // Make padding responsive
        ),
        onPressed: () {
          context.read<OnboardingCubit>().goToNextPage(context);
        },
        child: Icon(
          Icons.arrow_right_alt_outlined,
          size: isPortrait ? 24.sp : 16.sp, // Make icon size responsive
          color: Colors.white,
        ),
      ),
    );
  }
}
