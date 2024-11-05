import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product/product_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product/product_state.dart';
import 'package:selaty/features/home/presentation/widgets/product_card.dart';
import 'package:selaty/features/home/presentation/widgets/shimmer_loading_product_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.initial ||
            state.products == null ||
            state.products!.isEmpty) {
          return const ShimmerLoading();
        }

        if (state.status == ProductStatus.failure && state.products == null) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<FavoriteCubit>()..loadFavoriteItems(),
            ),
            BlocProvider(
              create: (context) => sl<CartCubit>()..loadCartItems(),
            ),
          ],
          child: ProductGrid(products: state.products!),
        );
      },
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length - 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index + 1],
          );
        },
      ),
    );
  }
}
