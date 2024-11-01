import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/product_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product_state.dart';
import 'package:selaty/features/home/presentation/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          // Show shimmer effect while products are loading
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 500,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: 6, // Placeholder items while loading
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.1 / 1.2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) => const ShimmerProductCard(),
              ),
            ),
          );
        } else if (state.status == ProductStatus.success &&
            state.products != null) {
          // Display products once loaded
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 500,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: state.products!.length - 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.1 / 1.2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final product = state.products![index + 1];
                  return ProductCard(
                    product: product,
                  );
                },
              ),
            ),
          );
        } else if (state.status == ProductStatus.failure) {
          // Show error message
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        // Initial state before fetching data
        return const Center(child: Text('No products available'));
      },
    );
  }
}

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            Container(
              height: 20,
              width: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
