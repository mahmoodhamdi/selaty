import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/cart_view.dart';

class ProductUiCard extends StatelessWidget {
  const ProductUiCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CartView()));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: isPortrait ? 35 : 35,
                  height: isPortrait ? 20 : 20, // Adjusted width
                  decoration: const BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
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
                    size: isPortrait ? 25 : 25, // Adjusted size
                  ),
                ),
              ],
            ),
            Expanded(
              child: Image.asset(
                'assets/images/fruits.png',
                // Adjusted width
              ),
            ),
            const SizedBox(
              height: 8, // Adjusted space
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8), // Adjusted padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 50, // Adjusted height
                      padding:
                          const EdgeInsets.only(right: 6), // Adjusted padding
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
                      '1 كيلو',
                      style: Styles.textStyle12.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8, // Adjusted space
            ),
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
                padding: const EdgeInsets.only(
                    top: 4, right: 8, left: 8, bottom: 4), // Adjusted padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      textDirection: TextDirection.ltr,
                      '40 EGP',
                      style: Styles.textStyle12Bold,
                    ),
                    Container(
                      height: isPortrait ? 30 : 30, // Adjusted height
                      width: isPortrait ? 30 : 30, // Adjusted width
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
