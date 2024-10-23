import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/presentation/widgets/offer_item.dart';

class OffersGridView extends StatelessWidget {
  const OffersGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24 / 3),
      child: SizedBox(
        height: isPortrait
            ? MediaQuery.sizeOf(context).height * 0.45
            : MediaQuery.sizeOf(context).height * 0.66,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
            mainAxisExtent: isPortrait
                ? MediaQuery.sizeOf(context).height * 0.2
                : MediaQuery.sizeOf(context).height * 0.3,
          ),
          itemBuilder: (context, index) => offers[index],
        ),
      ),
    );
  }
}

List<OfferItem> offers = [
  const OfferItem(
    color: secondarySkyBlue,
    discount: "15%",
    text: "عرض خاص",
  ),
  const OfferItem(
    color: secondaryOrange,
    discount: "55%",
    text: "عرض خاص",
  ),
  const OfferItem(
    color: primaryGreen,
    discount: "20%",
    text: "عرض خاص",
  ),
  const OfferItem(
    color: primaryRed,
    discount: "15%",
    text: "عرض خاص",
  ),
  const OfferItem(
    color: primaryBlue,
    discount: "10%",
    text: "عرض خاص",
  ),
  const OfferItem(
    color: primaryGreen,
    discount: "20%",
    text: "عرض خاص",
  ),
];
