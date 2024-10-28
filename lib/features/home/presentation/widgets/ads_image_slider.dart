import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_cubit.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_state.dart';

import 'carousel_item.dart';
import 'custom_indicators.dart';
import 'shimmer_loader.dart';

class AdsImageSlider extends StatefulWidget {
  const AdsImageSlider({super.key});

  @override
  State<AdsImageSlider> createState() => _AdsImageSliderState();
}

class _AdsImageSliderState extends State<AdsImageSlider>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late CarouselSliderController _carouselController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderImagesCubit, SliderImagesState>(
      builder: (context, state) {
        if (state.status == SliderImagesStatus.loading) {
          return const ShimmerLoader();
        } else if (state.status == SliderImagesStatus.failure) {
          return Center(
            child: Text(state.errorMessage ?? 'Error loading images'),
          );
        } else if (state.status == SliderImagesStatus.success) {
          return Column(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: state.images.length,
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.85,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                    _animationController.forward().then((_) {
                      _animationController.reverse();
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return CarouselItem(
                    imageUrl: state.images[index].img,
                    animation: _scaleAnimation,
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomIndicators(
                  count: state.images.length, currentIndex: _currentIndex),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
