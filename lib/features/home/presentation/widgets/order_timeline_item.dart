import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'order_step_model.dart';

class OrderTimelineItem extends StatelessWidget {
  final OrderStepModel orderStep;
  final bool isCompleted;
  final bool isActive;
  final bool isFirst;
  final bool isLast;
  final Size size;
  final bool isPortrait;

  const OrderTimelineItem({
    super.key,
    required this.orderStep,
    required this.isCompleted,
    required this.isActive,
    this.isFirst = false,
    this.isLast = false,
    required this.size,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isCompleted ? primaryGreen : Colors.grey.shade300,
        thickness: 2,

      ),
      indicatorStyle: IndicatorStyle(
        width: isPortrait ? size.width * 0.11 : size.height * 0.11,
        height: isPortrait ? size.width * 0.11 : size.height * 0.11,
        indicator: _buildIndicator(),
      ),
      endChild: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical:isPortrait? size.height * 0.025: size.width * 0.030,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderStep.text,
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.043 : size.height * 0.03,
                fontWeight: FontWeight.bold,
                color: isCompleted || isActive ? Colors.black : Colors.grey,
              ),
            ),
            SizedBox(height: size.height * 0.006),
            Text(
              orderStep.date != null
                  ? DateFormat.yMMMd().format(orderStep.date!)
                  : 'قيد الانتظار',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.037 : size.height * 0.027,
                color: isCompleted || isActive ? Colors.black54 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? primaryGreen : Colors.grey.shade300,
      ),
      child: Icon(
        orderStep.icon,
        color: isCompleted || isActive ? Colors.white : Colors.grey,
        size: isPortrait ? size.width * 0.06 : size.height * 0.06,
      ),
    );
  }
}
