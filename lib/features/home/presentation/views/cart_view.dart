import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_state.dart';
import 'package:selaty/features/home/presentation/widgets/cart_items_list.dart';
import 'package:selaty/features/home/presentation/widgets/cart_loading_shimmer.dart';
import 'package:selaty/features/home/presentation/widgets/empty_cart.dart';
import 'package:selaty/features/home/presentation/widgets/error_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryPurple,
        title: const Text("سلة التسوق",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            onPressed: () => context.read<CartCubit>().clear(),
            tooltip: 'إفراغ السلة',
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const CartLoadingShimmer();
          } else if (state is CartLoaded) {
            return state.items.isEmpty
                ? const EmptyCart()
                : CartItemsList(items: state.items);
          } else if (state is CartError) {
            return ErrorView(message: state.message);
          }
          return const EmptyCart();
        },
      ),
    );
  }
}
