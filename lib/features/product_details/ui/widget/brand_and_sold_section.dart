import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class BrandAndSoldSection extends StatelessWidget {
  final String? brandName;
  final int? soldCount;

  const BrandAndSoldSection({
    super.key,
    this.brandName,
    this.soldCount,
  });

  @override
  Widget build(BuildContext context) {
    if (brandName == null && soldCount == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (brandName != null) ...[
          Icon(
            Icons.local_offer_outlined,
            size: 16.sp,
            color: const Color(0xFF8E8E93),
          ),
          SizedBox(width: 4.w),
          Text(
            'Brand: $brandName',
            style: AppTextStyles.font14w400gray,
          ),
        ],
        if (brandName != null && soldCount != null) SizedBox(width: 16.w),
        if (soldCount != null) ...[
          Icon(
            Icons.shopping_bag_outlined,
            size: 16.sp,
            color: const Color(0xFF8E8E93),
          ),
          SizedBox(width: 4.w),
          Text(
            '$soldCount sold',
            style: AppTextStyles.font14w400gray,
          ),
        ],
      ],
    );
  }
}
