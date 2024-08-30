import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: primaryGreen,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                'محمود حمدي',
                style: Styles.textStyle16Bold.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                'hmdy7486@gmail.com',
                style: Styles.textStyle16.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Positioned(
          top: -60,
          right: MediaQuery.sizeOf(context).width * 0.5 - 100,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.2),
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
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
