import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_refresh_indicator.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_state.dart';
import 'package:selaty/features/home/presentation/widgets/favourite_product_card.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_empty.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_error.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_loading.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "المفضلة",
          style: TextStyle(
            color: primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          BlocBuilder<FavoriteCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoaded && state.items.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete_outline, color: primaryRed),
                  onPressed: () {
                    context.read<FavoriteCubit>().clear();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await context.read<FavoriteCubit>().loadFavoriteItems();
        },
        child: BlocBuilder<FavoriteCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const FavouritesLoading();
            } else if (state is FavoritesError) {
              return FavouritesError(
                errorMessage: state.message,
                onRetry: () =>
                    context.read<FavoriteCubit>().loadFavoriteItems(),
              );
            } else if (state is FavoritesLoaded) {
              final favorites = state.items;
              if (favorites.isEmpty) {
                return const FavouritesEmpty();
              }
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: secondarySkyBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: secondarySkyBlue,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${favorites.length} عنصر في المفضلة",
                                style: const TextStyle(
                                  color: secondarySkyBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final favoriteProduct = favorites[index];
                              return FavouriteProductCard(
                                favouriteProduct: favoriteProduct,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "لا توجد عناصر في المفضلة",
                  style: TextStyle(
                    color: secondaryPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
