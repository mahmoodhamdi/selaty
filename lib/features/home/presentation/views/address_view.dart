import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/successful_order_view.dart';
import 'package:selaty/features/home/presentation/widgets/address_list_item.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'عنوان التسليم',
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitLayout(context)
              : _buildLandscapeLayout(context);
        },
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: const AddressListItem(),
              ),
            ),
          ),
          PrimaryButton(
            text: 'التسليم لهذا العنوان',
            color: primaryGreen,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SuccessfulOrderView()));
            },
            height: 60.h,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20.h),
            Text(
              'يشحن الى :',
              style: Styles.textStyle18.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 8.sp,
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(16.0.h),
                          child: const AddressListItem(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: PrimaryButton(
                      text: 'التسليم لهذا العنوان',
                      color: primaryGreen,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessfulOrderView()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
