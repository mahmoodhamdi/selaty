import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class ProfileUtilBoxItem extends StatelessWidget {
  const ProfileUtilBoxItem({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    this.onTap,
  });

  final void Function()? onTap;
  final String title;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              Text(
                title,
                style: Styles.textStyle14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
