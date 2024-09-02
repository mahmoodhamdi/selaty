import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/presentation/widgets/product_card.dart';
import 'package:selaty/features/home/presentation/widgets/search_and_filter.dart';

class CategoryProductsView extends StatelessWidget {
  const CategoryProductsView({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 130,
                  decoration: const BoxDecoration(
                    color: primaryGreen,
                  ),
                  child: CustomAppBar(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'الفاكهة',
                    titleColor: Colors.white,
                  ),
                ),
                Positioned(
                  right: MediaQuery.sizeOf(context).width / 2 - 45,
                  bottom: -40,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/images/fruit_icon.png',
                        width: 70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          const SliverToBoxAdapter(
            child: SearchAndFilter(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) => const ProductCard(),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 4,
                  childAspectRatio: 1.4 / 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
            ),
          ),
        ],
      ),
    );
  }
}
