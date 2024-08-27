import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/home/presentation/views/home_view.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  final PageController pageController = PageController();
  int currentIndex = 0;
  void dotNavigationClicked(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(OnboardingUpdateIndicator());
  }

  goToNextPage(BuildContext context) {
    if (currentIndex != 2) {
      currentIndex++;

      pageController.jumpToPage(currentIndex);
      emit(OnboardingUpdateIndicator());
    } else {
      THelperFunctions.navigateReplacementToScreen(context, const HomeView());
    }
  }

  void updatePageIndicator(int index) {
    currentIndex = index;
    emit(OnboardingUpdateIndicator());
  }

  void skipPage() {
    currentIndex = 2;
    pageController.jumpToPage(currentIndex);
    emit(OnboardingUpdateIndicator());
  }
}
