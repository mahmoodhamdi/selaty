import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            Container(
              height: 20,
              width: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
