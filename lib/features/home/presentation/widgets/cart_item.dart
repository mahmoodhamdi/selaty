import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/collapsed_cart_item.dart';
import 'package:selaty/features/home/presentation/widgets/expanded_cart_item.dart';

class CartItem extends StatefulWidget {
  final double price;
  final String itemName;
  final String unit;

  const CartItem({
    super.key,
    required this.price,
    required this.itemName,
    required this.unit,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _isExpanded = false;
  int _count = 1;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > 1) _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpansion,
      child: _isExpanded
          ? ExpandedCartItem(
              count: _count,
              price: widget.price,
              itemName: widget.itemName,
              unit: widget.unit,
              onIncrement: _incrementCount,
              onDecrement: _decrementCount,
            )
          : CollapsedCartItem(
              count: _count,
              price: widget.price,
              itemName: widget.itemName,
              unit: widget.unit,
              onIncrement: _incrementCount,
              onDecrement: _decrementCount,
            ),
    );
  }
}
