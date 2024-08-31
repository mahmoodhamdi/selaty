import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('الاجمالي', style: Styles.textStyle20Bold),
        Text('100.00 SAR',
            textDirection: TextDirection.ltr, style: Styles.textStyle20Bold),
      ],
    );
  }
}
