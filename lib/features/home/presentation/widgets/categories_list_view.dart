import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/categories_cubit.dart';
import 'package:selaty/features/home/presentation/logic/categories_state.dart';
import 'package:selaty/features/home/presentation/views/category_products_view.dart';
import 'package:selaty/features/home/presentation/widgets/category_item.dart';
import 'package:shimmer/shimmer.dart';

class TopCategoriesListView extends StatelessWidget {
  const TopCategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6, // Number of shimmer placeholders
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 85,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state.status == CategoriesStatus.success) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories?.length ?? 0,
              itemBuilder: (context, index) {
                final category = state.categories![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsView(
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                  child: CategoryItem(
                    categoryName: category.name,
                    imageUrl: category.img,
                  ),
                );
              },
            );
          } else if (state.status == CategoriesStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Container(); // In case of initial or unknown state
          }
        },
      ),
    );
  }
}
