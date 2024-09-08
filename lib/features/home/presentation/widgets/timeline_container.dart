import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/order_step_model.dart';
import 'package:selaty/features/home/presentation/widgets/order_timeline_item.dart';

class TimelineContainer extends StatelessWidget {
  final Size size;
  final bool isPortrait;
  final List<OrderStepModel> orderSteps;
  final int currentStep;

  const TimelineContainer({
    super.key,
    required this.size,
    required this.isPortrait,
    required this.orderSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            for (int i = 0; i < orderSteps.length; i++)
              OrderTimelineItem(
                key: ValueKey<int>(i),
                orderStep: orderSteps[i],
                isCompleted: i <= currentStep,
                isActive: i == currentStep,
                isFirst: i == 0,
                isLast: i == orderSteps.length - 1,
                size: size,
                isPortrait: isPortrait,
              ),
          ],
        ),
      ),
    );
  }
}
