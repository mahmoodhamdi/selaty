import 'package:flutter/material.dart';
import 'package:selaty/core/constants/sizes.dart';
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
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularBackground(
              size: MediaQuery.of(context).size.width * 0.8,
              image: onBoardingModel.image,
              color: onBoardingModel.color),
          SizedBox(
            height: isPortrait ? 60 : 10,
          ),
          Text(
            onBoardingModel.title,
            style: Styles.textStyle28.copyWith(
                color: onBoardingModel.color, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            onBoardingModel.subTitle,
            style: Styles.textStyle20.copyWith(color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
