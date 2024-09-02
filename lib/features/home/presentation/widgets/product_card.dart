import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/cart_view.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CartView()));
      },
      child: Container(
        width: 150.w, // Adjusted width
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30.w, // Adjusted width
                  height: 15.h, // Adjusted height
                  decoration: const BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                      topRight: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'جديد',
                      style: Styles.textStyle12.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.solidHeart,
                    color: primaryGreen,
                    size: 16.w, // Adjusted size
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/images/fruits.png',
              height: 50.h, // Adjusted height
              width: 120.w, // Adjusted width
            ),
            const SizedBox(
              height: 8, // Adjusted space
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w), // Adjusted padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60.w, // Adjusted width
                      height: 15.h, // Adjusted height
                      padding: EdgeInsets.only(right: 6.w), // Adjusted padding
                      alignment: Alignment.centerRight,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Text(
                        'فواكه',
                        style: Styles.textStyle12.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      'طبق فواكه',
                      style: Styles.textStyle12.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '1 kg',
                      style: Styles.textStyle12.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                  )
                ],
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    right: 8.w, left: 8.w, bottom: 4.h), // Adjusted padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      textDirection: TextDirection.ltr,
                      '40 EGP',
                      style: Styles.textStyle12Bold,
                    ),
                    Container(
                      height: 24.h, // Adjusted height
                      width: 24.w, // Adjusted width
                      decoration: const BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.calendarPlus,
                        color: Colors.white,
                        size: 14, // Adjusted size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
