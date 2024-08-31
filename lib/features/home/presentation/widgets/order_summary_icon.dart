import 'package:flutter/material.dart';

class OrderSummaryIcon extends StatelessWidget {
  const OrderSummaryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Colors.white,
      radius: 50,
      child: Icon(
        Icons.free_breakfast_outlined,
        size: 50,
      ),
    );
  }
}
