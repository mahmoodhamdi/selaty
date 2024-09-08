import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/address_view.dart';
import 'package:selaty/features/home/presentation/widgets/cart_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'سلة التسوق',
      ),
      body: isPortrait
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Product List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 5,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CartItem(
                        price: 30.0,
                        itemName: "مانجا عويسي",
                        unit: "كيلو",
                      ),
                    ),
                  ),
                ),
                // Total and Payment Section pinned at the top
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'البنود',
                                    style: Styles.textStyle18Bold
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    'المجموع الفرعي',
                                    style: Styles.textStyle18Bold
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    'رسوم التوصيل',
                                    style: Styles.textStyle18Bold
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '4',
                                    textDirection: TextDirection.ltr,
                                    style: Styles.textStyle16Bold
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    r'100.00 $',
                                    textDirection: TextDirection.ltr,
                                    style: Styles.textStyle16Bold
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    'Free',
                                    textDirection: TextDirection.ltr,
                                    style: Styles.textStyle16Bold
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الاجمالي',
                                style: Styles.textStyle20Bold,
                              ),
                              Text(
                                '100.00 SAR',
                                textDirection: TextDirection.ltr,
                                style: Styles.textStyle20Bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    text: 'الدفع',
                    color: primaryGreen,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressView(),
                        ),
                      );
                    },
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )
          : SafeArea(
              child: Row(
                children: [
                  // Total and Payment Section on the right
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4, // 40% width
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'البنود',
                                  style: Styles.textStyle18Bold
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  'المجموع الفرعي',
                                  style: Styles.textStyle18Bold
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  'رسوم التوصيل',
                                  style: Styles.textStyle18Bold
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '4',
                                  textDirection: TextDirection.ltr,
                                  style: Styles.textStyle16Bold
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  r'100.00 $',
                                  textDirection: TextDirection.ltr,
                                  style: Styles.textStyle16Bold
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  'Free',
                                  textDirection: TextDirection.ltr,
                                  style: Styles.textStyle16Bold
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الاجمالي',
                              style: Styles.textStyle20Bold,
                            ),
                            Text(
                              '100.00 SAR',
                              textDirection: TextDirection.ltr,
                              style: Styles.textStyle20Bold,
                            ),
                          ],
                        ),
                        PrimaryButton(
                          text: 'الدفع',
                          color: primaryGreen,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddressView(),
                              ),
                            );
                          },
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  // Product List on the left
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 5,
                      itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CartItem(
                          price: 30.0,
                          itemName: "مانجا عويسي",
                          unit: "كيلو",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
