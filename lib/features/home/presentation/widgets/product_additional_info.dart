import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';

class ProductAdditionalInfo extends StatelessWidget {
  final Product product;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const ProductAdditionalInfo({
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
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              if (product.sku != null) _buildInfoRow('SKU', product.sku!),
              _buildInfoRow('الرقم الضريبي', product.barcodeNumber),
              _buildInfoRow('كود المنتج', product.productCode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: secondaryPurple, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
