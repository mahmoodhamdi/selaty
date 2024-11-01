import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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

class _MainViewState extends State<MainView> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
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
            create: (context) => sl<ProductCubit>()..fetchProducts(1),
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

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(FontAwesomeIcons.cartShopping),
        ),
        title: ("Cart"),
        activeColorPrimary: primaryGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
        ),
        title: ("Home"),
        activeColorPrimary: primaryGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.favorite_border),
        ),
        title: ("Favorites"),
        activeColorPrimary: primaryGreen,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
