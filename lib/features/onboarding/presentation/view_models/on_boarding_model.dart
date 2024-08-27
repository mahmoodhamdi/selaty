import 'package:flutter/material.dart';

class OnboardingViewModel {
  final String image;
  final String title;
  final Color color;
  final String subTitle;
  OnboardingViewModel(
      {required this.image,
      required this.color,
      required this.title,
      required this.subTitle});
}
