import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_state.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_state.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  final Product product;
  final AnimationController controller;
  final Animation<double> fadeAnimation;

  const BottomNavigationBarComponent({
    super.key,
    required this.product,
    required this.controller,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - fadeAnimation.value)),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Row(
              children: [
                // Add to Cart button
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: BlocConsumer<CartCubit, CartState>(
                      listener: (context, state) {
                        if (state is CartError) {
                          THelperFunctions.showSnackBar(
                            type: SnackBarType.error,
                            context: context,
                            message: 'خطأ في إضافة المنتج إلى السلة',
                          );
                        }
                      },
                      builder: (context, state) {
                        bool isInCart = false;
                        if (state is CartLoaded) {
                          isInCart =
                              state.items.any((item) => item.id == product.id);
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (isInCart) {
                              // Remove from cart
                              context
                                  .read<CartCubit>()
                                  .removeItem(product.id.toString());
                            } else {
                              // Add to cart
                              context.read<CartCubit>().addItem(
                                    CartItem(
                                      productQuantity: product.quantity,
                                      imageUrl:
                                          "${ApiConstants.imageUrl}${product.img}",
                                      id: product.id,
                                      name: product.name,
                                      price: product.price,
                                      quantity: 1,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            isInCart ? 'حذف من السلة' : 'إضافة للسلة',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Add to Favorites button
                Expanded(
                  child: BlocConsumer<FavoriteCubit, FavoritesState>(
                    listener: (context, state) {
                      if (state is FavoritesError) {
                        THelperFunctions.showSnackBar(
                          type: SnackBarType.error,
                          context: context,
                          message: 'حدث خطأ أثناء الإضافة إلى المفضلة',
                        );
                      } else if (state is FavoritesLoaded) {}
                    },
                    builder: (context, state) {
                      bool isInFavorites = false;
                      if (state is FavoritesLoaded) {
                        isInFavorites =
                            state.items.any((item) => item.id == product.id);
                      }

                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isInFavorites) {
                              // Remove from favorites
                              context
                                  .read<FavoriteCubit>()
                                  .removeFavorite(product.id.toString());
                            } else {
                              // Add to favorites
                              context.read<FavoriteCubit>().addFavorite(
                                    FavoriteItem(
                                      price: product.price,
                                      quantity: product.quantity,
                                      img:
                                          "${ApiConstants.imageUrl}${product.img}",
                                      id: product.id,
                                      name: product.name,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryPurple,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state is FavoritesLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  isInFavorites
                                      ? 'حذف من المفضلة'
                                      : 'إضافة للمفضلة',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
