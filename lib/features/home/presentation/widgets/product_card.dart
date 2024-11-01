import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/views/cart_view.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                    Text(
                      maxLines: 2,
                      product.name,
                      style: Styles.textStyle12.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      product.quantity == 0
                          ? 'غير متوفر'
                          : ' متبقي ${product.quantity}',
                      style: Styles.textStyle12.copyWith(
                        color: product.quantity == 0
                            ? primaryRed
                            : Colors.grey.shade600,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${product.price} EGP',
                      style: Styles.textStyle12Bold,
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
