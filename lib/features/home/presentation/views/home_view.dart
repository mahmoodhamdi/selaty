import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/features/home/presentation/widgets/ad_widget.dart';
import 'package:selaty/features/home/presentation/widgets/ads_image_slider.dart';
import 'package:selaty/features/home/presentation/widgets/categories_list_view.dart';
import 'package:selaty/features/home/presentation/widgets/fresh_products_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/header_section.dart';
import 'package:selaty/features/home/presentation/widgets/interest_free_discount_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/offers_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/products_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/sections_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 24.h), // Use ScreenUtil for padding
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
              child: AdsImageSlider(),
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
                height: 18.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionsHeader(
                title: 'تسوق حسب العروض',
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: OffersGridView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 18.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionsHeader(
                title: 'طازج وسريع',
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: FreshProductsGridView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: AdWidget(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionsHeader(
                title: 'انتهز الفرصه',
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: InterestFreeDiscountGridView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 18.h, // Use ScreenUtil for spacing
              ),
            ),
          ],
        ),
      ),
    );
  }
}
