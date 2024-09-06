import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16, // dynamic positioning
      left: 24,
      child: TextButton(
        onPressed: context.read<OnboardingCubit>().skipPage,
        child: Text(
          'تخطي',
          style: TextStyle(
            color: primaryGreen,
            fontSize:
                MediaQuery.of(context).size.height * 0.02, // dynamic font size
          ),
        ),
      ),
    );
  }
}
