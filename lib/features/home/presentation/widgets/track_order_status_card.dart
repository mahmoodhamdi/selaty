import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/track_order_list_item.dart';

class TrackOrderStatusCard extends StatelessWidget {
  final bool isPortrait;

  const TrackOrderStatusCard({super.key, required this.isPortrait});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isPortrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            TrackOrderListItem(text: 'تم الطلب', icon: Icons.list_alt_outlined),
            TrackOrderListItem(text: 'Order', icon: Icons.list),
            TrackOrderListItem(text: 'تم شحن الطب', icon: Icons.list),
            TrackOrderListItem(text: 'خارج الخدمة', icon: Icons.list),
            TrackOrderListItem(
                text: 'اجل تسليم', icon: Icons.check_circle_sharp),
          ],
        ),
      ),
    );
  }
}
