import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/checkout_button.dart';
import 'package:selaty/features/home/presentation/widgets/order_details.dart';
import 'package:selaty/features/home/presentation/widgets/total_price.dart';

class OrderSummaryLandscape extends StatelessWidget {
  const OrderSummaryLandscape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            OrderDetails(),
            Spacer(),
            TotalPrice(),
            CheckoutButton(),
          ],
        ),
      ),
    );
  }
}
