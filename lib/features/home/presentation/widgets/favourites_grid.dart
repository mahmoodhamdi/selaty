import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_state.dart';
import 'package:selaty/features/home/presentation/widgets/favourite_product_card.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_empty.dart';

class FavouritesGrid extends StatelessWidget {
  final List<FavouriteData> initialFavourites;

  const FavouritesGrid({super.key, required this.initialFavourites});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavouritesCubit>()
        ..emit(FavouritesState(favouriteList: initialFavourites)),
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.50 / 0.95,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: state.favouriteList.length,
              itemBuilder: (context, index) {
                final favouriteData = state.favouriteList[index];
                final favouriteProduct = favouriteData.product;

                if (favouriteProduct == null) {
                  return const FavouritesEmpty();
                }

                return FavouriteProductCard(
                  favouriteProduct: favouriteProduct,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
