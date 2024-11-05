import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_refresh_indicator.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_state.dart';
import 'package:selaty/features/home/presentation/widgets/favourite_product_card.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_empty.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_error.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_loading.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavouritesCubit>()..fetchUserFavourites(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "المفضلة",
            style: TextStyle(
              color: primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            context.read<FavouritesCubit>().fetchUserFavourites();
          },
          child: BlocBuilder<FavouritesCubit, FavouritesState>(
            builder: (context, state) {
              switch (state.status) {
                case FavouritesStatus.fetchingFavouritesLoading:
                  return const FavouritesLoading();
                case FavouritesStatus.fetchingFavouritesFailure:
                  return FavouritesError(
                    errorMessage: state.message ?? "Error loading favourites",
                    onRetry: () =>
                        context.read<FavouritesCubit>().fetchUserFavourites(),
                  );
                case FavouritesStatus.fetchingFavouritesSuccess:
                  final favourites = state.favouriteList;
                  if (favourites.isEmpty) {
                    return const FavouritesEmpty();
                  }
                  return BlocBuilder<FavouritesCubit, FavouritesState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                  );

                default:
                  return const Center(child: Text("لا توجد المفضلات"));
              }
            },
          ),
        ),
      ),
    );
  }
}
