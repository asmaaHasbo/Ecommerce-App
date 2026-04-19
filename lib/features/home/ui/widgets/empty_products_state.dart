import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class EmptyProductsState extends StatelessWidget {
  final bool isSearchResult;
  final String? searchQuery;

  const EmptyProductsState({
    super.key,
    this.isSearchResult = false,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearchResult ? Icons.search_off : Icons.shopping_bag_outlined,
              size: 120.sp,
              color: AppColors.mainColor.withValues(alpha: 0.3),
            ),
            SizedBox(height: 24.h),
            Text(
              isSearchResult ? 'No Results Found' : 'No Products Found',
              style: AppTextStyles.font17w600Black,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              isSearchResult
                  ? 'No products found for "${searchQuery ?? ''}".\n\nTry:\n• Check your spelling\n• Use different keywords\n• Browse categories instead'
                  : 'There are no products in this category yet.\nTry selecting another category.',
              style: AppTextStyles.font15W400lightGray,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
