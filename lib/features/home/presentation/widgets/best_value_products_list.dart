import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/best_value_item.dart';

class BestValueProductsList extends StatelessWidget {
  const BestValueProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const BestValueItem();
        },
      ),
    );
  }
}
