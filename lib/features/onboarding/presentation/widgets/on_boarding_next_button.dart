import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/sizes.dart';
import 'package:selaty/core/device/device_utility.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: TSizes.defaultSpace,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: primaryGreen,
          ),
          onPressed: (() {
            context.read<OnboardingCubit>().goToNextPage(context);
          }),
          child: const Icon(
            Icons.arrow_right_alt_outlined,
            size: 30,
            color: Colors.white,
          ),
        ));
  }
}
