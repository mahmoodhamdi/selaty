import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/order_details.dart';
import 'package:selaty/features/home/presentation/widgets/total_price.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              OrderDetails(),
              SizedBox(height: 30),
              TotalPrice(),
            ],
          ),
        ),
      ),
    );
  }
}
