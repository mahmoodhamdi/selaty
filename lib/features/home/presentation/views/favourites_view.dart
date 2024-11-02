import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_refresh_indicator.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites_state.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_empty.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_error.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_grid.dart';
import 'package:selaty/features/home/presentation/widgets/favourites_loading.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          context.read<GetUserFavouritesCubit>().fetchUserFavourites();
        },
        child: BlocBuilder<GetUserFavouritesCubit, GetUserFavouritesState>(
          builder: (context, state) {
            if (state.status == GetUserFavouritesStatus.loading) {
              return const FavouritesLoading();
            } else if (state.status == GetUserFavouritesStatus.failure) {
              return FavouritesError(
                errorMessage: state.errorMessage!,
                onRetry: () => context
                    .read<GetUserFavouritesCubit>()
                    .fetchUserFavourites(),
              );
            } else if (state.status == GetUserFavouritesStatus.success) {
              final favourites = state.favourites;
              if (favourites == null || favourites.isEmpty) {
                return const FavouritesEmpty();
              }
              return BlocProvider(
                create: (context) => sl<AddToFavouritesCubit>(),
                child: FavouritesGrid(initialFavourites: favourites),
              );
            }
            return const Center(child: Text("لا توجد المفضلات"));
          },
        ),
      ),
    );
  }
}
