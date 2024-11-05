import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_state.dart';
import 'package:selaty/features/home/presentation/views/product_details_view.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<FavouritesCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => sl<CartCubit>()..loadCartItems(),
                  ),
                ],
                child: ProductDetailsView(product: product),
              ),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocConsumer<FavouritesCubit, FavouritesState>(
                  listener: (context, state) {
                    if (state.status ==
                        FavouritesStatus.fetchingFavouritesSuccess) {
                      isFavorite = state.favouriteList
                          .any((element) => element.product?.id == product.id);
                    }
                  },
                  builder: (context, state) {
                    if (state.status ==
                        FavouritesStatus.fetchingFavouritesFailure) {
                      return IconButton(
                          onPressed: () {},
                          icon: const SizedBox(
                              height: 25, width: 25, child: Icon(Icons.error)));
                    } else {
                      return IconButton(
                          onPressed: () {
                            context
                                .read<FavouritesCubit>()
                                .addToFavourites(product.id);
                            if (state.status ==
                                FavouritesStatus.addingToFavouritesSuccess) {
                              isFavorite = !isFavorite;
                            }
                          },
                          icon: Icon(
                            isFavorite
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: primaryGreen,
                            size: isPortrait ? 25 : 25,
                          ));
                    }
                  },
                ),
              ]),
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
        ));
  }
}
