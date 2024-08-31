import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/routes/routes.dart';
import 'package:selaty/features/home/presentation/widgets/address_list_item.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'عنوان التسليم',
      ),
      body: isPortrait
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'يشحن الى',
                      style: Styles.textStyle18.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: AddressListItem(),
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    text: 'التسليم لهذا العنوان',
                    color: primaryGreen,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.successfulOrderView);
                    },
                    width: MediaQuery.sizeOf(context).width,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'يشحن الى :',
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => const SizedBox(
                                width: 345,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: AddressListItem(),
                                )),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: PrimaryButton(
                            text: 'التسليم لهذا العنوان',
                            color: primaryGreen,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.successfulOrderView);
                            },
                            width: MediaQuery.sizeOf(context).width,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
