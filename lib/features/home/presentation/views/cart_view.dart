import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/features/home/presentation/widgets/cart_landscape_layout.dart';
import 'package:selaty/features/home/presentation/widgets/cart_portrait_layout.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'عربة التسوق'),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const CartPortraitLayout()
              : const CartLandscapeLayout();
        },
      ),
    );
  }
}
