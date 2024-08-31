
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/styles.dart';

class CounterColumn extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterColumn({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(FontAwesomeIcons.plus, size: 16),
        ),
        Text(
          count.toString(),
          style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(FontAwesomeIcons.minus, size: 16),
        ),
      ],
    );
  }
}
