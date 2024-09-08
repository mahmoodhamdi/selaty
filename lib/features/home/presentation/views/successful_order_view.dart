import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/track_order_view.dart';

class SuccessfulOrderView extends StatelessWidget {
  const SuccessfulOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'عربة التسوق',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isPortrait ? screenWidth / 20 : screenWidth / 20,
              ),
              child: Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/success_bag_icon.png',
                      width: isPortrait ? screenWidth / 2 : screenWidth / 8,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'طلبك ناجح !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isPortrait
                            ? screenWidth * 0.05
                            : screenWidth * 0.025,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PrimaryButton(
                        text: 'ترتيب المسار',
                        color: const Color(0xff38344B),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TrackOrderView()));
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
