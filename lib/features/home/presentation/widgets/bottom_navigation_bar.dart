import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites/add_to_favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites/add_to_favourites_state.dart';
import 'package:selaty/features/home/presentation/views/sub_categorios_view.dart';

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
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'إضافة للسلة',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<AddToFavouritesCubit,
                        AddToFavouritesState>(
                      listener: (context, state) {
                        if (state.status == AddToFavouritesStatus.success) {
                          THelperFunctions.showSnackBar(
                              context: context, message: state.message!);
                        } else if (state.status ==
                            AddToFavouritesStatus.failure) {
                          THelperFunctions.showSnackBar(
                              context: context,
                              message: state.message ?? 'خطاء في الإضافة');
                        }
                      },
                      builder: (context, state) {
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
                              context
                                  .read<AddToFavouritesCubit>()
                                  .addToFavourites(product.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryPurple,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: state.status == AddToFavouritesStatus.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'إضافة للمفضلة',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
