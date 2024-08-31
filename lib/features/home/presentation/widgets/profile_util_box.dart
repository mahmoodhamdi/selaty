import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/presentation/widgets/profile_util_box_item.dart';

class ProfileUtilBox extends StatelessWidget {
  // profile_util_box.dart
  const ProfileUtilBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProfileUtilBoxItem(
          color: primaryGreen,
          icon: Icons.logout,
          title: 'خروج',
        ),
        SizedBox(
          width: 25,
        ),
        ProfileUtilBoxItem(
          color: primaryRed,
          icon: Icons.help_center_outlined,
          title: 'مركز الدعم',
        ),
      ],
    );
  }
}
