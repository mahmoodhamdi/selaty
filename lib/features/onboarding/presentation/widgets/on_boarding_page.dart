import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/device/device_utility.dart';
import 'package:selaty/features/onboarding/presentation/view_models/on_boarding_model.dart';
import 'package:selaty/features/onboarding/presentation/widgets/circular_background.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.onBoardingModel,
  });
  final OnboardingViewModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    final isPortrait = TDeviceUtils.isPortraitOrientation(context);
    return Padding(
      padding: EdgeInsets.all(24.w), // Make padding responsive
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularBackground(
            size: MediaQuery.of(context).size.width *
                0.8.w, // Make size responsive
            image: onBoardingModel.image,
            color: onBoardingModel.color,
          ),
          SizedBox(
            height: isPortrait ? 60.h : 10.h, // Make height responsive
          ),
          Text(
            onBoardingModel.title,
            style: Styles.textStyle28.copyWith(
              color: onBoardingModel.color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.h, // Make height responsive
          ),
          Text(
            onBoardingModel.subTitle,
            style: Styles.textStyle20.copyWith(
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
