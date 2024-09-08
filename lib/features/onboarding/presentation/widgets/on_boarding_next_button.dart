import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 25,
      left: 24,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: primaryGreen,
          padding: EdgeInsets.all(screenSize.height * 0.015), // dynamic padding
        ),
        onPressed: () {
          context.read<OnboardingCubit>().goToNextPage(context);
        },
        child: Icon(
          Icons.arrow_right_alt_outlined,
          size: screenSize.height * 0.05, // dynamic icon size
          color: Colors.white,
        ),
      ),
    );
  }
}
