import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/product_card.dart';

class FreshProductsGridView extends StatelessWidget {
  const FreshProductsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: 500,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 1.2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20),
          itemBuilder: (context, index) => const ProductCard(),
        ),
      ),
    );
  }
}
