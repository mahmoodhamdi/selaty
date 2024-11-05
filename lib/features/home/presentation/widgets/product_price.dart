import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';

class ProductPrice extends StatelessWidget {
  final Product product;
  final AnimationController controller;

  const ProductPrice(
      {super.key, required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.value,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('السعر :', style: Theme.of(context).textTheme.titleLarge),
                Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
