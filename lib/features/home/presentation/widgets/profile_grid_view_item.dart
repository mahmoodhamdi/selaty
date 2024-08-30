import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class ProfileGridViewItem extends StatelessWidget {
  const ProfileGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: Colors.white,
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              //use font awesome icons
              FontAwesomeIcons.person,
              color: primaryRed,
              size: 32,
            ),
            Text(
              'عنـي',
              style: Styles.textStyle12Bold,
            ),
          ],
        ),
      ),
    );
  }
}
