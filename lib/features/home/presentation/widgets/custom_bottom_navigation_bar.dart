import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/routes/routes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: 2,
      items: [
        BottomNavigationBarItem(
          label: 'profile',
          icon: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.profileView);
              },
              child: const Icon(Icons.person_outline)),
        ),
        const BottomNavigationBarItem(
          label: 'Browse',
          icon: Icon(Icons.notifications_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Icon',
          icon: Container(
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
        const BottomNavigationBarItem(
          label: 'Favorites',
          icon: Icon(Icons.favorite_border),
        ),
        const BottomNavigationBarItem(
          label: 'search',
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
