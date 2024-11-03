import 'package:flutter/material.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:selaty/features/home/presentation/widgets/product_additional_info.dart';
import 'package:selaty/features/home/presentation/widgets/product_description.dart';
import 'package:selaty/features/home/presentation/widgets/product_image.dart';
import 'package:selaty/features/home/presentation/widgets/product_price.dart';
import 'package:selaty/features/home/presentation/widgets/product_title.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProductImage(product: widget.product),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitle(
                        product: widget.product,
                        fadeAnimation: _fadeAnimation,
                        slideAnimation: _slideAnimation,
                      ),
                      const SizedBox(height: 20),
                      ProductPrice(
                          product: widget.product, controller: _controller),
                      const SizedBox(height: 20),
                      ProductDescription(
                          product: widget.product,
                          fadeAnimation: _fadeAnimation,
                          slideAnimation: _slideAnimation),
                      const SizedBox(height: 20),
                      ProductAdditionalInfo(
                          product: widget.product,
                          fadeAnimation: _fadeAnimation,
                          slideAnimation: _slideAnimation),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarComponent(
          product: widget.product,
          controller: _controller,
          fadeAnimation: _fadeAnimation),
    );
  }
}
