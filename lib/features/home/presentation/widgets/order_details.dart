import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'البنود',
              style: Styles.textStyle18Bold.copyWith(color: Colors.grey),
            ),
            Text(
              'المجموع الفرعي',
              style: Styles.textStyle18Bold.copyWith(color: Colors.grey),
            ),
            Text(
              'رسوم التوصيل',
              style: Styles.textStyle18Bold.copyWith(color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '4',
              style: Styles.textStyle18Bold.copyWith(color: Colors.grey),
            ),
            Text(
              r'100.00 $',
              style: Styles.textStyle18Bold.copyWith(color: Colors.grey),
            ),
            Text(
              'Free',
              style: Styles.textStyle18Bold.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
