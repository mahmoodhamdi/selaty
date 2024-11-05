import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const ProductDescription({
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
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الوصف :',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: secondaryPurple, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(product.details,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
