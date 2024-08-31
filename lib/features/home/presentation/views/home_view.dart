import 'package:flutter/material.dart';
import 'package:selaty/core/constants/sizes.dart';
import 'package:selaty/core/routes/routes.dart';
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
        padding: const EdgeInsets.only(top: TSizes.defaultSpace),
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            const SliverToBoxAdapter(
              child: HeaderSection(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(
                  title: 'القيمه الافضل',
                  subTitle: 'اعلى المبيعات',
                  onTap: () {}),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            const SliverToBoxAdapter(
              child: BestValueProductsList(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(
                  title: 'التصنيفات',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.categoriesView);
                  }),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            const SliverToBoxAdapter(child: CategoriesListView()),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'الأكثر مبيعا', onTap: () {}),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            const SliverToBoxAdapter(
              child: BestSellerProductsGridView(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'تسوق حسب العروض', onTap: () {}),
            ),
            const SliverToBoxAdapter(
              child: OffersGridView(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'طازج وسريع', onTap: () {}),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            const SliverToBoxAdapter(
              child: FreshProductsGridView(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            const SliverToBoxAdapter(
              child: AdWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: SeeAllWidget(title: 'انتهز الفرصه', onTap: () {}),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            const SliverToBoxAdapter(
              child: InterestFreeDiscountGridView(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
