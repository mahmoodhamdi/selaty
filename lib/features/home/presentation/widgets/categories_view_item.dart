import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/presentation/views/category_products_view.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesViewItem extends StatelessWidget {
  final String categoryName;
  final String imageUrl;
  const CategoriesViewItem(
      {super.key, required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CategoryProductsView(
                      categoryName: 'فواكه',
                    )));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              categoryName,
              style: Styles.textStyle18,
            ),
            const Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: 'https://marketappmaster.com/uploads/$imageUrl',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 60,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 50
                          : 55,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child: Image.asset(
                        'assets/images/category_icon.png',
                        width: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
