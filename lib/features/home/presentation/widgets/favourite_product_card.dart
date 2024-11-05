import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_state.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_cubit.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteProductCard extends StatelessWidget {
  final FavoriteItem favouriteProduct;

  const FavouriteProductCard({
    super.key,
    required this.favouriteProduct,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details if needed
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final isInCart = state is CartLoaded &&
                      state.items.any((item) => item.id == favouriteProduct.id);

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
                          ? cubit.removeItem(favouriteProduct.id.toString())
                          : cubit.addItem(CartItem(
                              imageUrl: favouriteProduct.img,
                              id: favouriteProduct.id,
                              name: favouriteProduct.name,
                              price: favouriteProduct.price,
                              quantity: 1,
                            ));
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  context
                      .read<FavoriteCubit>()
                      .removeFavorite(favouriteProduct.id.toString());
                },
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              imageUrl: "${ApiConstants.imageUrl}${favouriteProduct.img}",
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[200],
                  height: 100,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.error,
                  color: primaryRed,
                  size: 40,
                ),
              ),
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
                    favouriteProduct.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle12.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    favouriteProduct.quantity == 0
                        ? 'غير متوفر'
                        : 'متبقي ${favouriteProduct.quantity}',
                    style: Styles.textStyle12.copyWith(
                      color: favouriteProduct.quantity == 0
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
                  '${favouriteProduct.price} EGP',
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
