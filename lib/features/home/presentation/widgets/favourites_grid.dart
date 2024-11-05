import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_state.dart';
import 'package:selaty/features/home/presentation/widgets/favourite_product_card.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_empty.dart';

class FavouritesGrid extends StatelessWidget {
  final List<FavoriteItem> initialFavourites;

  const FavouritesGrid({super.key, required this.initialFavourites});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FavoriteCubit>()..emit(FavoritesLoaded(initialFavourites)),
      child: BlocBuilder<FavoriteCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FavoritesLoaded) {
            final favourites = state.items;
            if (favourites.isEmpty) {
              return const FavouritesEmpty();
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.50 / 0.95,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  final favouriteProduct = favourites[index];
                  return FavouriteProductCard(
                    favouriteProduct: favouriteProduct,
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No favorites available"));
          }
        },
      ),
    );
  }
}
