import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
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
          SliverAppBar(
            backgroundColor: primaryGreen,
            pinned: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: primaryGreen,
              ),
            ),
            actions: [
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                categoryName,
                style: Styles.textStyle18.copyWith(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: primaryGreen,
                  ),
                ),
                Positioned(
                  right: MediaQuery.sizeOf(context).width / 2 - 80,
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
