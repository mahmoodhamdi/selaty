import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class CartItemDetails extends StatelessWidget {
  final int count;
  final double price;
  final String itemName;
  final String unit;

  const CartItemDetails({
    super.key,
    required this.count,
    required this.price,
    required this.itemName,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${(price * count).toStringAsFixed(2)}\$ x$count',
          textDirection: TextDirection.ltr,
          style: Styles.textStyle16Bold.copyWith(color: primaryGreen),
        ),
        Text(
          itemName,
          style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          unit,
          textDirection: TextDirection.ltr,
          style: Styles.textStyle16,
        ),
      ],
    );
  }
}
