import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/presentation/widgets/order_summary_details.dart';
import 'package:selaty/features/home/presentation/widgets/order_summary_icon.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OrderSummaryDetails(),
            OrderSummaryIcon(),
          ],
        ),
      ),
    );
  }
}
