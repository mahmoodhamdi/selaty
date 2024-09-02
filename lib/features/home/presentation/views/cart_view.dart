import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/empty_shopping_cart_view.dart';
import 'package:selaty/features/home/presentation/widgets/cart_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: CustomAppBar(
                title: 'عربة التسوق',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ];
        },
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
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
                  const SizedBox(height: 20),
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
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PrimaryButton(
                      text: 'الدفع',
                      color: primaryGreen,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmptyShoppingCartView(),
                          ),
                        );
                      },
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: 5,
                      itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CartItem(
                          itemName: "مانجا عويسي",
                          unit: "كيلو",
                          price: 30.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          const Spacer(),
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
                                  builder: (context) =>
                                      const EmptyShoppingCartView(),
                                ),
                              );
                            },
                            width: double.infinity,
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
