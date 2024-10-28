import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'shimmer_loader.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final Animation<double> animation;

  const CarouselItem(
      {required this.imageUrl, required this.animation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: 'https://marketappmaster.com/uploads/$imageUrl',
                fit: BoxFit.cover,
                placeholder: (context, url) => const ShimmerLoader(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
