import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/features/home/presentation/widgets/order_summary_card.dart';
import 'package:selaty/features/home/presentation/widgets/track_order_status_card.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'ترتيب المسار',
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isPortrait ? 20 : screenWidth / 4),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const OrderSummaryCard(),
              const SizedBox(height: 20),
              TrackOrderStatusCard(isPortrait: isPortrait),
            ],
          ),
        ),
      ),
    );
  }
}
