import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/profile_view.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            },
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.orange,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Text(
                'محمود حمدي',
                style: Styles.textStyle16,
              ),
              Row(
                children: [
                  const CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.locationDot,
                        color: primaryRed,
                        size: 16,
                      )),
                  Text(
                    'المنوفية - شبين الكوم',
                    style: Styles.textStyle16.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 35.0, // Adjust the width as needed
            height: 35.0, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  // Your onPressed logic here
                },
                iconSize: 16, // Adjust the icon size as needed
                icon: const Icon(
                  Icons.camera_alt_outlined,
                ),
                color: Colors.black, // Set the icon color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
