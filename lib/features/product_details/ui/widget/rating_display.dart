import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class RatingDisplay extends StatelessWidget {
  final double? rating;
  final int? reviewsCount;

  const RatingDisplay({
    super.key,
    this.rating,
    this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    if (rating == null && reviewsCount == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 16.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          rating?.toStringAsFixed(1) ?? '0.0',
          style: AppTextStyles.font14w500maincolor,
        ),
        if (reviewsCount != null) ...[
          SizedBox(width: 4.w),
          Text(
            '($reviewsCount reviews)',
            style: AppTextStyles.font12w400gray,
          ),
        ],
      ],
    );
  }
}
