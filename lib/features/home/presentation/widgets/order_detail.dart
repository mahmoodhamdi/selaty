import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class OrderDetail extends StatelessWidget {
  final String label;
  final String value;

  const OrderDetail(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Styles.textStyle12.copyWith(color: Colors.white),
        ),
        Text(
          value,
          style: Styles.textStyle12.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
