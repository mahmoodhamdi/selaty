import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/strings.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/onboarding/presentation/view_models/on_boarding_model.dart';
import 'package:selaty/features/onboarding/presentation/widgets/on_boarding_dot_navigation.dart';
import 'package:selaty/features/onboarding/presentation/widgets/on_boarding_next_button.dart';
import 'package:selaty/features/onboarding/presentation/widgets/on_boarding_page.dart';
import 'package:selaty/features/onboarding/presentation/widgets/on_boarding_skip_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    sharedPreferences.setBool('IS_FIRST_TIME', true);

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final pageController = context.read<OnboardingCubit>().pageController;
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().updatePageIndicator(index);
                },
                physics: const BouncingScrollPhysics(),
                children: [
                  OnboardingPage(
                      onBoardingModel: OnboardingViewModel(
                    image: 'assets/images/shop.png',
                    title: Strings.onBoardingTitle1,
                    subTitle: Strings.onBoardingSubTitle1,
                    color: primaryRed,
                  )),
                  OnboardingPage(
                      onBoardingModel: OnboardingViewModel(
                    image: 'assets/images/shop.png',
                    title: Strings.onBoardingTitle2,
                    subTitle: Strings.onBoardingSubTitle2,
                    color: primaryGreen,
                  )),
                  OnboardingPage(
                    onBoardingModel: OnboardingViewModel(
                      title: Strings.onBoardingTitle3,
                      subTitle: Strings.onBoardingSubTitle3,
                      image: "assets/images/delivery.png",
                      color: secondaryPurple,
                    ),
                  ),
                ],
              ),
              const OnboardingSkipButton(),
              const OnboardingDotNavigation(),
              const OnboardingNextButton(),
            ],
          ),
        );
      },
    );
  }
}
