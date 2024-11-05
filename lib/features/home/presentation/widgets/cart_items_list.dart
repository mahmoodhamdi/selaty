import 'package:flutter/material.dart';
import 'package:selaty/features/home/data/models/cart.dart';

import 'cart_item_card.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItem> items;

  const CartItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return isLandscape && isTablet
        ? GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => CartItemCard(item: items[index]),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) => CartItemCard(item: items[index]),
          );
  }
}
