import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_state.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_state.dart';
import 'package:selaty/features/home/presentation/views/product_details_view.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(product: product),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final isInCart = state is CartLoaded &&
                      state.items.any((item) => item.id == product.id);

                  return IconButton(
                    icon: Icon(
                      isInCart
                          ? Icons.shopping_cart
                          : Icons.add_shopping_cart_outlined,
                      color: primaryGreen,
                    ),
                    onPressed: () {
                      final cubit = context.read<CartCubit>();
                      isInCart
                          ? cubit.removeItem(product.id.toString())
                          : cubit.addItem(CartItem(
                              imageUrl: product.img,
                              id: product.id,
                              name: product.name,
                              price: product.price,
                              quantity: 1,
                            ));
                    },
                  );
                },
              ),
              BlocBuilder<FavoriteCubit, FavoritesState>(
                builder: (context, state) {
                  final isInFavorites = state is FavoritesLoaded &&
                      state.items.any((fav) => fav.id == product.id);

                  return IconButton(
                    icon: Icon(
                      isInFavorites ? Icons.favorite : Icons.favorite_border,
                      color: isInFavorites ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      final favoriteCubit = context.read<FavoriteCubit>();
                      isInFavorites
                          ? favoriteCubit.removeFavorite(product.id.toString())
                          : favoriteCubit.addFavorite(
                              FavoriteItem(
                                id: product.id,
                                name: product.name,
                                img: product.img,
                                price: product.price,
                                quantity: product.quantity,
                              ),
                            );
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              imageUrl: "${ApiConstants.imageUrl}${product.img}",
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(color: Colors.grey[200], height: 100),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    style: Styles.textStyle12.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    product.quantity == 0
                        ? 'غير متوفر'
                        : 'متبقي ${product.quantity}',
                    style: Styles.textStyle12.copyWith(
                      color: product.quantity == 0
                          ? primaryRed
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  '${product.price} EGP',
                  style: Styles.textStyle12Bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
