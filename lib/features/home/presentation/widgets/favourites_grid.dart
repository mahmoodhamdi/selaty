import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites_state.dart';
import 'package:selaty/features/home/presentation/widgets/favourite_product_card.dart';

class FavouritesGrid extends StatelessWidget {
  final List<FavouriteData> favourites;

  const FavouritesGrid({super.key, required this.favourites});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddToFavouritesCubit>(),
      child: Padding(
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
            final favouriteData = favourites[index];
            final favouriteProduct = favouriteData.product;
            if (favouriteProduct == null) {
              return const SizedBox.shrink();
            }
            return BlocListener<AddToFavouritesCubit, AddToFavouritesState>(
              listener: (context, state) {
                if (state.status == AddToFavouritesStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                      backgroundColor: primaryGreen,
                    ),
                  );
                } else if (state.status == AddToFavouritesStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? 'حدث خطأ'),
                      backgroundColor: primaryRed,
                    ),
                  );
                }
              },
              child: FavouriteProductCard(
                favouriteProduct: favouriteProduct,
                onRemoveFavorite: () {
                  context
                      .read<AddToFavouritesCubit>()
                      .addToFavourites(favouriteProduct.id);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
