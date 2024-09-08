import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/features/home/presentation/widgets/next_step_button.dart';
import 'package:selaty/features/home/presentation/widgets/order_info_card.dart';
import 'package:selaty/features/home/presentation/widgets/order_step_model.dart';
import 'package:selaty/features/home/presentation/widgets/timeline_container.dart';

class TrackOrderView extends StatefulWidget {
  const TrackOrderView({super.key});

  @override
  State<TrackOrderView> createState() => _TrackOrderViewState();
}

class _TrackOrderViewState extends State<TrackOrderView> {
  int currentStep = 0;
  List<OrderStepModel> orderSteps = [
    OrderStepModel(text: 'تم الطلب', icon: Icons.list_alt_outlined),
    OrderStepModel(text: 'تم شحن الطلب', icon: Icons.local_shipping),
    OrderStepModel(text: 'خارج الخدمة', icon: Icons.home),
    OrderStepModel(text: 'اجل تسليم', icon: Icons.check_circle_sharp),
  ];

  void nextStep() {
    if (currentStep < orderSteps.length - 1) {
      setState(() {
        currentStep++;
        orderSteps[currentStep].date = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xffE5F9FF),
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'ترتيب المسار',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Column(
              children: [
                OrderInfoCard(size: size, isPortrait: isPortrait),
                SizedBox(height: size.height * 0.03),
                TimelineContainer(
                  size: size,
                  isPortrait: isPortrait,
                  orderSteps: orderSteps,
                  currentStep: currentStep,
                ),
                SizedBox(height: size.height * 0.03),
                NextStepButton(
                  size: size,
                  onNextPressed: nextStep,
                  isStepCompleted: currentStep >= orderSteps.length - 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
