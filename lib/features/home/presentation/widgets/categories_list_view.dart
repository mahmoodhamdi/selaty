import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/views/category_products_view.dart';
import 'package:selaty/features/home/presentation/widgets/category_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryProductsView(
                              categoryName: 'فواكه',
                            )));
              },
              child: const CategoryItem());
        },
      ),
    );
  }
}
