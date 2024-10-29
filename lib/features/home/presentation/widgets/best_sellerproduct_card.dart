import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/views/cart_view.dart';
import 'package:shimmer/shimmer.dart';

class BestSellerProductCard extends StatelessWidget {
  final Product product;
  final List<String> categoryNames;
  const BestSellerProductCard(
      {super.key, required this.product, required this.categoryNames});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartView()),
        );
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
                  height: isPortrait ? 20 : 20,
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
                    product.isFavorite == 1
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: primaryGreen,
                    size: isPortrait ? 25 : 25,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: CachedNetworkImage(
                imageUrl: "https://marketappmaster.com/uploads/${product.img}",
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[200],
                      height: 100,
                    )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 50,
                      padding: const EdgeInsets.only(right: 6),
                      alignment: Alignment.centerRight,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Text(
                        product.categoryId.toString(),
                        style: Styles.textStyle12.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      product.name,
                      style: Styles.textStyle12.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      ' متبقي ${product.quantity}',
                      style: Styles.textStyle12.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
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
                padding:
                    const EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price} EGP',
                      style: Styles.textStyle12Bold,
                    ),
                    Container(
                      height: isPortrait ? 30 : 30,
                      width: isPortrait ? 30 : 30,
                      decoration: const BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.calendarPlus,
                        color: Colors.white,
                        size: 14,
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
