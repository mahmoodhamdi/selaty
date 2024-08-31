import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/cart_list.dart';
import 'package:selaty/features/home/presentation/widgets/order_summary_lanscape.dart';

class CartLandscapeLayout extends StatelessWidget {
  const CartLandscapeLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(child: CartList()),
          SizedBox(width: 10),
          OrderSummaryLandscape(),
        ],
      ),
    );
  }
}
