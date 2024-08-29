import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/sizes.dart';
import 'package:selaty/core/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      right: TSizes.defaultSpace,
      child: SmoothPageIndicator(
          controller: context.read<OnboardingCubit>().pageController,
          count: 3,
          axisDirection: Axis.horizontal,
          onDotClicked: (index) {
            context.read<OnboardingCubit>().dotNavigationClicked(index);
          },
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 16,
            activeDotColor: primaryGreen,
          )),
    );
  }
}
