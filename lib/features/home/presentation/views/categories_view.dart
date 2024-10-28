import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/categories_cubit.dart';
import 'package:selaty/features/home/presentation/logic/categories_state.dart';
import 'package:selaty/features/home/presentation/widgets/categories_view_item.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'التصنيفات',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state.status == CategoriesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == CategoriesStatus.success) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.categories?.length ?? 0,
                      (context, index) {
                        final category = state.categories![index];
                        return CategoriesViewItem(
                          categoryName: category.name,
                          imageUrl: category.img,
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 4,
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                  ),
                ],
              );
            } else if (state.status == CategoriesStatus.failure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return Container(); // In case of initial state
            }
          },
        ),
      ),
    );
  }
}
