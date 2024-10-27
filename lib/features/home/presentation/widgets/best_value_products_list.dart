import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_cubit.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_state.dart';
import 'package:selaty/features/home/presentation/widgets/best_value_item.dart';
import 'package:shimmer/shimmer.dart';

class BestValueProductsList extends StatelessWidget {
  const BestValueProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderImagesCubit, SliderImagesState>(
      builder: (context, state) {
        if (state.status == SliderImagesStatus.loading) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Show 5 placeholders for loading
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder(); // Shimmer effect
              },
            ),
          );
        } else if (state.status == SliderImagesStatus.failure) {
          return Center(
            child: Text(state.errorMessage ?? 'Error loading images'),
          );
        } else if (state.status == SliderImagesStatus.success) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                final image = state.images[index];
                return BestValueItem(imageUrl: image.img); // Pass image data
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  // Shimmer placeholder builder
  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 330,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
