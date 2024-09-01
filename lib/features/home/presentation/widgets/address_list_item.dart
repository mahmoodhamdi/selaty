import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class AddressListItem extends StatefulWidget {
  const AddressListItem({
    super.key,
  });

  @override
  State<AddressListItem> createState() => _AddressListItemState();
}

class _AddressListItemState extends State<AddressListItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: isPortrait ? 1.sw : 345.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: Text(
                      'افتراضي',
                      style: Styles.textStyle12Bold.copyWith(
                        color: primaryGreen,
                        fontSize: isPortrait ? 12.sp : 8.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              isClicked
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isClicked = false;
                        });
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.r)),
                          border: Border.all(color: primaryRed, width: 2.w),
                        ),
                        child: Icon(
                          Icons.circle,
                          color: primaryRed,
                          size: isPortrait ? 18.sp : 8.sp,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isClicked = true;
                        });
                      },
                      icon: Icon(
                        Icons.circle_outlined,
                        color: Colors.black,
                        size: isPortrait ? 18.sp : 8.sp,
                      ),
                    ),
              Text(
                'المـنـزل',
                style: Styles.textStyle16Bold
                    .copyWith(fontSize: isPortrait ? 16.sp : 10.sp),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.ellipsis,
                  size: isPortrait ? 18.sp : 8.sp,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ح حمدي فتحي الأشوح - ش داير الناحيه\n ح حمدي فتحي الأشوح -   ش المنوفيه',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle16Bold.copyWith(
                  color: Colors.grey,
                  fontSize: isPortrait ? 14.sp : 8.sp,
                ),
              ),
              Text(
                ' الباجور - المنوفيه',
                style: Styles.textStyle16Bold.copyWith(
                  color: Colors.grey,
                  fontSize: isPortrait ? 14.sp : 8.sp,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                Text(
                  'جوال : ',
                  style: Styles.textStyle16Bold
                      .copyWith(fontSize: isPortrait ? 14.sp : 8.sp),
                ),
                Text(
                  '01019793768',
                  style: Styles.textStyle16Bold
                      .copyWith(fontSize: isPortrait ? 14.sp : 8.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
