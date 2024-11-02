import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc for cubits
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/widgets/custom_refresh_indicator.dart';
import 'package:selaty/features/home/presentation/logic/categories_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product_cubit.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_cubit.dart';
import 'package:selaty/features/home/presentation/widgets/ads_image_slider.dart';
import 'package:selaty/features/home/presentation/widgets/categories_list_view.dart';
import 'package:selaty/features/home/presentation/widgets/header_section.dart';
import 'package:selaty/features/home/presentation/widgets/products_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/sections_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    // Fetch products, categories, and slider images
    await Future.wait([
      context.read<ProductCubit>().fetchProducts(1),
      context.read<CategoriesCubit>().fetchCategories(),
      context.read<SliderImagesCubit>().fetchSliderImages(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 24.h), // Use ScreenUtil for padding
        child: CustomRefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 18.h, // Use ScreenUtil for spacing
                ),
              ),
              const SliverToBoxAdapter(
                child: HeaderSection(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 18.h, // Use ScreenUtil for spacing
                ),
              ),
              const SliverToBoxAdapter(
                child: AdImageSlider(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 18.h, // Use ScreenUtil for spacing
                ),
              ),
              const SliverToBoxAdapter(
                child: SectionsHeader(
                  title: 'التصنيفات',
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.h, // Use ScreenUtil for spacing
                ),
              ),
              const SliverToBoxAdapter(
                child: TopCategoriesListView(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 18.h, // Use ScreenUtil for spacing
                ),
              ),
              const SliverToBoxAdapter(
                child: SectionsHeader(
                  title: 'الأكثر مبيعا',
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.h, // Use ScreenUtil for spacing
                ),
              ),
              const SliverToBoxAdapter(
                child: ProductsGridView(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50.h, // Use ScreenUtil for spacing
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
