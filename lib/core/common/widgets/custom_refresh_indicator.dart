import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: 3.0,

      onRefresh: onRefresh,
      color: primaryGreen, // Primary color for the indicator
      backgroundColor: Colors.white, // Background color for the indicator
      child: child,
    );
  }
}
