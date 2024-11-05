import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';

import 'quantity_control.dart';

class CartItemCard extends StatelessWidget {
  final dynamic item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id.toString()),
      background: Container(
        color: Colors.red,
        child: const Center(
          child: Text("حذف", style: TextStyle(color: Colors.white)),
        ),
      ),
      onDismissed: (direction) {
        context.read<CartCubit>().removeItem(item.id.toString());
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildItemImage(),
              const SizedBox(width: 16),
              _buildItemDetails(),
              QuantityControl(item: item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: "${ApiConstants.imageUrl}${item.imageUrl}",
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
      ),
    );
  }

  Widget _buildItemDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("${item.price} جنيه",
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
