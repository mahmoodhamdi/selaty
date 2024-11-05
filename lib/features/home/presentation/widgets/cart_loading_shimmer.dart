import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartLoadingShimmer extends StatelessWidget {
  const CartLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
