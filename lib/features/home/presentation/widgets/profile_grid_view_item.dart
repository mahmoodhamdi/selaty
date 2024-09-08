import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class ProfileGridViewItem extends StatelessWidget {
  const ProfileGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                //use font awesome icons
                FontAwesomeIcons.person,
                color: primaryRed,
                size: 32,
              ),
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
