import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class NextStepButton extends StatelessWidget {
  final Size size;
  final VoidCallback onNextPressed;
  final bool isStepCompleted;

  const NextStepButton({
    super.key,
    required this.size,
    required this.onNextPressed,
    required this.isStepCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.018,
        ),
        backgroundColor: isStepCompleted ? Colors.grey : primaryGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: isStepCompleted ? null : onNextPressed,
      child: Text(
        isStepCompleted ? "تم التسليم بنجاح" : "الخطوة التالية",
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.02,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
