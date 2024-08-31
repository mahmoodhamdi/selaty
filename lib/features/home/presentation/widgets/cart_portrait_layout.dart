import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/cart_list.dart';
import 'package:selaty/features/home/presentation/widgets/checkout_button.dart';
import 'package:selaty/features/home/presentation/widgets/order_summary.dart';

class CartPortraitLayout extends StatelessWidget {
  const CartPortraitLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: CartList()),
        SizedBox(height: 20),
        OrderSummary(),
        SizedBox(height: 10),
        CheckoutButton(),
      ],
    );
  }
}
