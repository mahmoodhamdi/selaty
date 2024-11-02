import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesLoading extends StatelessWidget {
  const CategoriesLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 85,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}
