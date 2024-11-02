import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_loading.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: 500,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.1 / 1.2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) => const ShimmerProductCard(),
        ),
      ),
    );
  }
}
