import 'package:flutter/material.dart';
import 'package:selaty/core/routes/routes.dart';
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
                Navigator.pushNamed(context, Routes.categoryProductsView,
                    arguments: 'فواكه');
              },
              child: const CategoryItem());
        },
      ),
    );
  }
}
