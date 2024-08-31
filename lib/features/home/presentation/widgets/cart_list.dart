import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/cart_item.dart';

class CartList extends StatelessWidget {
  const CartList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 5,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CartItem(
          price: 30.0,
          itemName: "مانجا عويسي",
          unit: "كيلو",
        ),
      ),
    );
  }
}
