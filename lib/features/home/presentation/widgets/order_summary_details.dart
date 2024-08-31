import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/widgets/order_detail.dart';

class OrderSummaryDetails extends StatelessWidget {
  const OrderSummaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'معرف الطلب : ',
              style: Styles.textStyle18Bold.copyWith(color: Colors.white),
            ),
            Text(
              '#OD2204',
              style: Styles.textStyle18Bold.copyWith(color: Colors.white),
            ),
          ],
        ),
        Text(
          'تاريخ النشر ${DateFormat.yMMMMd().format(DateTime.now())}',
          style: Styles.textStyle12.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            OrderDetail('البنود : ', '15'),
            SizedBox(width: 30),
            OrderDetail('الاجمالي : ', '100 ريال'),
          ],
        ),
      ],
    );
  }
}
