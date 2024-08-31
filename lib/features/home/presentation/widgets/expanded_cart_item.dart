import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/cart_item_details.dart';
import 'package:selaty/features/home/presentation/widgets/counter_column.dart';
import 'package:selaty/features/home/presentation/widgets/delete_button.dart';

class ExpandedCartItem extends StatelessWidget {
  final int count;
  final double price;
  final String itemName;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ExpandedCartItem({
    super.key,
    required this.count,
    required this.price,
    required this.itemName,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          const DeleteButton(),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CounterColumn(
                    count: count,
                    onIncrement: onIncrement,
                    onDecrement: onDecrement,
                  ),
                  const Spacer(),
                  CartItemDetails(
                    count: count,
                    price: price,
                    itemName: itemName,
                    unit: unit,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
