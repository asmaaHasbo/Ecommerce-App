import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Icon(
            Icons.favorite_border_rounded,
            size: 120.sp,
            color: AppColors.lightGray.withValues(alpha: .3),
          ),
          SizedBox(height: 24.h),

          Text('Your Wishlist is Empty', style: AppTextStyles.font20w600black),
          SizedBox(height: 12.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'Explore more and add your favorite products to wishlist',
              style: AppTextStyles.font14w400gray,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
