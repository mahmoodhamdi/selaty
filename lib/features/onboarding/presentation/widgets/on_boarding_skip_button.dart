import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/device/device_utility.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = Orientation.portrait == MediaQuery.of(context).orientation;
    return Positioned(
      top: TDeviceUtils.getAppBarHeight().h, // Make the top position responsive
      left: 24.w, // Make the left position responsive
      child: TextButton(
        onPressed: context.read<OnboardingCubit>().skipPage,
        child: Text(
          'تخطي',
          style: TextStyle(
            color: primaryGreen,
            fontSize: isPortrait ? 16.sp : 10.sp, // Make the font size responsive
          ),
        ),
      ),
    );
  }
}
