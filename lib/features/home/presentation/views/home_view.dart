import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/common/widgets/custom_refresh_indicator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/categories/categories_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product/product_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product/product_state.dart';
import 'package:selaty/features/home/presentation/logic/slider_images/slider_images_cubit.dart';
import 'package:selaty/features/home/presentation/widgets/ads_image_slider.dart';
import 'package:selaty/features/home/presentation/widgets/categories_list_view.dart';
import 'package:selaty/features/home/presentation/widgets/header_section.dart';
import 'package:selaty/features/home/presentation/widgets/products_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/sections_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<ProductCubit>().state;
      if (state.status != ProductStatus.loadingMore && state.hasMoreData) {
        context.read<ProductCubit>().loadMore();
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.75);
  }

  Future<void> _onRefresh(BuildContext context) async {
    // Fetch products, categories, and slider images
    await Future.wait([
      context.read<ProductCubit>().fetchProducts(),
      context.read<CategoriesCubit>().fetchCategories(),
      context.read<SliderImagesCubit>().fetchSliderImages(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: CustomRefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: CustomScrollView(
            controller: _scrollController,
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 18.h),
              ),
              const SliverToBoxAdapter(
                child: HeaderSection(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 18.h),
              ),
              const SliverToBoxAdapter(
                child: AdImageSlider(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 18.h),
              ),
              const SliverToBoxAdapter(
                child: SectionsHeader(title: 'التصنيفات'),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 8.h),
              ),
              const SliverToBoxAdapter(
                child: TopCategoriesListView(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 18.h),
              ),
              const SliverToBoxAdapter(
                child: SectionsHeader(title: 'الأكثر مبيعا'),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 8.h),
              ),
              const SliverToBoxAdapter(
                child: ProductsGridView(),
              ),
              // Loading indicator for pagination
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state.status == ProductStatus.loadingMore) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  if (state.status == ProductStatus.failure &&
                      state.products != null) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: Text('Error: ${state.errorMessage}'),
                        ),
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: SizedBox(height: 50.h),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
