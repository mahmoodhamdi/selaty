import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';

class ProductTitle extends StatelessWidget {
  final Product product;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const ProductTitle({
    super.key,
    required this.product,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Text(
          product.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: secondaryPurple),
        ),
      ),
    );
  }
}
