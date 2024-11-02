import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/presentation/logic/categories_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product_cubit.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_cubit.dart';
import 'package:selaty/features/home/presentation/views/favourites_view.dart';
import 'package:selaty/features/home/presentation/views/home_view.dart';
import 'package:selaty/features/home/presentation/views/user_cart_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      const UserCartView(),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<SliderImagesCubit>()..fetchSliderImages(),
          ),
          BlocProvider(
            create: (context) => sl<CategoriesCubit>()..fetchCategories(),
          ),
          BlocProvider(
            create: (context) => sl<ProductCubit>()..fetchProducts(),
          ),
          BlocProvider(
            create: (context) =>
                sl<GetUserFavouritesCubit>()..fetchUserFavourites(),
          ),
        ],
        child: const HomeView(),
      ),
      BlocProvider(
        create: (context) =>
            sl<GetUserFavouritesCubit>()..fetchUserFavourites(),
        child: const FavouritesView(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      _animationController.reset();
      _animationController.forward();
      setState(() {
        _selectedIndex = index;
        _pageController.jumpToPage(index);
      });
    }
  }

  void _onPopInvokedWithResult(bool didPop, dynamic result) {
    if (didPop && _selectedIndex != 1) {
      _onItemTapped(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return PopScope(
      canPop: _selectedIndex == 1,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildScreens(),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: isLandscape ? 70.0 : 85.0 + bottomPadding,
                padding: EdgeInsets.only(bottom: bottomPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, -3),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavBarItem(
                      index: 0,
                      icon: FontAwesomeIcons.bagShopping,
                      label: 'Cart',
                      activeColor: primaryRed,
                    ),
                    _buildNavBarItem(
                      index: 1,
                      isLogo: true,
                      label: 'Home',
                      activeColor: primaryGreen,
                    ),
                    _buildNavBarItem(
                      index: 2,
                      icon: _selectedIndex == 2
                          ? Icons.favorite
                          : Icons.favorite_border,
                      label: 'Favorites',
                      activeColor: secondaryOrange,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem({
    required int index,
    IconData? icon,
    required String label,
    bool isLogo = false,
    required Color activeColor,
  }) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLogo) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? primaryGreen.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ] else ...[
              Icon(
                icon,
                size: 24,
                color: isSelected ? activeColor : secondaryPurple,
              ),
            ],
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : secondaryPurple,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
