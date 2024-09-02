import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/features/home/presentation/views/categories_view.dart';
import 'package:selaty/features/home/presentation/widgets/Interest_free_discount_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/ad_widget.dart';
import 'package:selaty/features/home/presentation/widgets/best_seller_products_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/best_value_products_list.dart';
import 'package:selaty/features/home/presentation/widgets/categories_list_view.dart';
import 'package:selaty/features/home/presentation/widgets/fresh_products_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/header_section.dart';
import 'package:selaty/features/home/presentation/widgets/offers_grid_view.dart';
import 'package:selaty/features/home/presentation/widgets/see_all_widget.dart';

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
            SliverToBoxAdapter(
              child: SeeAllWidget(
                  title: 'القيمه الافضل',
                  subTitle: 'اعلى المبيعات',
                  onTap: () {}),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: BestValueProductsList(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 18.h, // Use ScreenUtil for spacing
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(
                  title: 'التصنيفات',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesView()));
                  }),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: CategoriesListView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 18.h, // Use ScreenUtil for spacing
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'الأكثر مبيعا', onTap: () {}),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.h, // Use ScreenUtil for spacing
              ),
            ),
            const SliverToBoxAdapter(
              child: BestSellerProductsGridView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 18.h, // Use ScreenUtil for spacing
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'تسوق حسب العروض', onTap: () {}),
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
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'طازج وسريع', onTap: () {}),
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
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'انتهز الفرصه', onTap: () {}),
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
