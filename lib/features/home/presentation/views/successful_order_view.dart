import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/routes/routes.dart';

class SuccessfulOrderView extends StatelessWidget {
  const SuccessfulOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'عربة التسوق',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isPortrait ? 16 : screenWidth / 4,
          ),
          child: Container(
            height: isPortrait ? screenHeight * 0.8 : screenHeight * 0.7,
            width: screenWidth,
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/success_bag_icon.png',
                  width: isPortrait ? screenWidth : screenWidth /6,
                ),
                const SizedBox(height: 10),
                 Text(
                  'طلبك ناجح !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isPortrait ? 24 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    textAlign: TextAlign.center,
                    'شكرا على الطلب .. ستحصل عليه فى خلال بضع دقائق',
                    style: Styles.textStyle12.copyWith(color: Colors.white),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    text: 'ترتيب المسار',
                    color: const Color(0xff38344B),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.trackOrderView);
                    },
                    width: double.infinity,
                    height: isPortrait ? 60 : 40,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
