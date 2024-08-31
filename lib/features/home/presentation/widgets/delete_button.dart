import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 80,
      decoration: const BoxDecoration(
        color: primaryRed,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Icon(FontAwesomeIcons.trashCan, color: Colors.white),
    );
  }
}
