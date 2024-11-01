import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavouritesLoading extends StatelessWidget {
  const FavouritesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.1 / 1.2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
        ),
        itemCount: 6, // Placeholder items while loading
        itemBuilder: (context, index) => const ShimmerProductCard(),
      ),
    );
  }
}

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
