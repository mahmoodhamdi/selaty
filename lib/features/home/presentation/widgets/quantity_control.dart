import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';

class QuantityControl extends StatelessWidget {
  final CartItem item;

  const QuantityControl({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, () {
          if (item.quantity > 1) {
            context
                .read<CartCubit>()
                .updateItemQuantity(item.id.toString(), item.quantity - 1);
          }
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("${item.quantity}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        _buildButton(Icons.add, () {
          if (item.productQuantity > item.quantity) {
            context
                .read<CartCubit>()
                .updateItemQuantity(item.id.toString(), item.quantity + 1);
          } else {
            THelperFunctions.showSnackBar(
                type: SnackBarType.success,
                context: context,
                message:
                    "الكمية المتاحة لهذا المنتج هي ${item.productQuantity}");
          }
        }),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: primaryBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 20, color: primaryBlue),
        ),
      ),
    );
  }
}
