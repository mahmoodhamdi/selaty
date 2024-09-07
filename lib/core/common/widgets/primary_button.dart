import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.color,
      this.onTap,
      this.width = double.infinity,
      this.height});
  final String text;
  final Color color;
  final void Function()? onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: width ?? double.infinity,
          height: height ?? (isPortrait ? screenWidth / 7 : 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
            ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: Styles.textStyle18.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
