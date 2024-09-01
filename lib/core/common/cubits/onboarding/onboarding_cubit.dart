import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/features/auth/presentation/views/auth_view.dart';

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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthView()));
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
