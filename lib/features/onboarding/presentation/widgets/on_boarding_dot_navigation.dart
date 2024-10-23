import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom +
          25, // use MediaQuery for bottom positioning
      right: 24, // use a fixed margin for simplicity
      child: SmoothPageIndicator(
        controller: context.read<OnboardingCubit>().pageController,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight:
              MediaQuery.of(context).size.height * 0.01, // dynamic dot height
          dotWidth:
              MediaQuery.of(context).size.width * 0.05, // dynamic dot width
          activeDotColor: primaryGreen,
          spacing: 8, // optional fixed spacing
        ),
      ),
    );
  }
}
