import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 30,
      child: Container(
        decoration: const BoxDecoration(
          color: secondaryOlive,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        height: 50,
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
