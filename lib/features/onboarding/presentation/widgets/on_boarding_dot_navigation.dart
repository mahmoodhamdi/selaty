import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (TDeviceUtils.getBottomNavigationBarHeight() + 25)
          .h, // Make bottom position responsive
      right: 24.w, // Make right position responsive
      child: SmoothPageIndicator(
        controller: context.read<OnboardingCubit>().pageController,
        count: 3,
        axisDirection: Axis.horizontal,
        onDotClicked: (index) {
          context.read<OnboardingCubit>().dotNavigationClicked(index);
        },
        effect: ExpandingDotsEffect(
          dotHeight: 8.h, // Make dot height responsive
          dotWidth: 16.w, // Make dot width responsive
          activeDotColor: primaryGreen,
          spacing: 4.w, // Optional: Add spacing between dots, if needed
        ),
      ),
    );
  }
}
