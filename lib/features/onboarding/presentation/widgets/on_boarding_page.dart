import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05), // 5% padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularBackground(
            image: onBoardingModel.image,
            color: onBoardingModel.color,
          ),
          SizedBox(
              height: isPortrait
                  ? screenSize.height * 0.02
                  : screenSize.height * 0.01), // dynamic spacing
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              onBoardingModel.title,
              style: Styles.textStyle28.copyWith(
                color: onBoardingModel.color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              onBoardingModel.subTitle,
              style: Styles.textStyle20.copyWith(color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height:isPortrait? screenSize.height * 0.05: screenSize.height * 0.1),
        ],
      ),
    );
  }
}
