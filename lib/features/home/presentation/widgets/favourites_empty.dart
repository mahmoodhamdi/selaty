import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class FavouritesEmpty extends StatelessWidget {
  const FavouritesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border,
            color: primaryGreen,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            "لا توجد منتجات في المفضلة",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
