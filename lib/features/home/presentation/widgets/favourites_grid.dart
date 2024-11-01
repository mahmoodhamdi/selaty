import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/presentation/widgets/favourite_product_card.dart';

class FavouritesGrid extends StatelessWidget {
  final List<FavouriteData> favourites; // Change to FavouriteData

  const FavouritesGrid({super.key, required this.favourites});

  @override
  Widget build(BuildContext context) {
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
          final favouriteData = favourites[index];
          final favouriteProduct =
              favouriteData.product; // Assuming this exists
          if (favouriteProduct == null) {
            return const SizedBox.shrink();
          }
          return FavouriteProductCard(
            favouriteProduct: favouriteProduct,
            onRemoveFavorite: () {
              // TODO: Implement remove from favorites logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم إزالة ${favouriteProduct.name} من المفضلة'),
                  backgroundColor: primaryRed,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
