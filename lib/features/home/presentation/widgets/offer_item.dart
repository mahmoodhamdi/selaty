import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({
    super.key,
    required this.color,
    required this.text,
    required this.discount,
  });
  final Color color;
  final String text;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              discount,
              style: Styles.textStyle32,
            ),
          ),
          Expanded(
            child: Text(
              'خصم',
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
