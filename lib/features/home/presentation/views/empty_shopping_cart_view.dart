import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/routes/routes.dart';

class EmptyShoppingCartView extends StatelessWidget {
  const EmptyShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'عربة التسوق',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20
                        : MediaQuery.sizeOf(context).width / 4),
            child: Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.sizeOf(context).height * 0.7
                  : MediaQuery.sizeOf(context).height * 0.7,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: primaryRed,
                    size: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width / 3
                        : MediaQuery.sizeOf(context).height / 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'عربة التسوق فارغة !',
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'اجعل سلتك سعيدة وأضف منتجات',
                    style: Styles.textStyle12Bold.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: PrimaryButton(
                      text: 'ابدأ التسوق',
                      color: primaryGreen,
                      onTap: () {
                        Navigator.pushNamed(context, Routes.addressView);
                      },
                      width: double.infinity,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 60
                          : 40,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
