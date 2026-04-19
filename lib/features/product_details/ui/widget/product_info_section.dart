import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/rating_display.dart';

class ProductInfoSection extends StatelessWidget {
  final String? category;
  final String? name;
  final String? price;
  final double? rating;
  final int? reviewsCount;

  const ProductInfoSection({
    super.key,
    this.category,
    this.name,
    this.price,
    this.rating,
    this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category ?? 'Category', style: AppTextStyles.font12w400gray),
              SizedBox(height: 8.h),
              Text(name ?? 'Product Name', style: AppTextStyles.font20w700black),
              SizedBox(height: 8.h),
              RatingDisplay(rating: rating, reviewsCount: reviewsCount),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Price', style: AppTextStyles.font12w400gray),
            SizedBox(height: 8.h),
            Text(price ?? '\$0', style: AppTextStyles.font24w700black),
          ],
        ),
      ],
    );
  }
}
