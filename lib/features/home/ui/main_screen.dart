// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/di/dependency_injection.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:laza_ecommerce_app/features/cart/ui/cart_screen.dart';
import 'package:laza_ecommerce_app/features/home/ui/home_screen.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:laza_ecommerce_app/features/wishlist/ui/wishlist_screen.dart';
import 'package:laza_ecommerce_app/features/profile/ui/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const WishlistScreen(),
      BlocProvider(
        create: (context) => CartCubit(getIt()..getCartProducts()),
        child: const CartScreen(),
      ),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: 'Wishlist',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.shopping_bag_outlined,
                activeIcon: Icons.shopping_bag,
                label: 'Cart',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.person,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });

        // Refresh wishlist when navigating to wishlist tab
        if (index == 1) {
          context.read<WishlistCubit>().getWishlist();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: (isActive ? 16 : 12),
          vertical: 8,
        ),

        child: Row(
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? Colors.transparent : AppColors.iconGray,
              size: 24,
            ),
            if (isActive) ...[
              // SizedBox(e 8),
              Text(label, style: AppTextStyles.font15w500Purple),
            ],
          ],
        ),
      ),
    );
  }
}
