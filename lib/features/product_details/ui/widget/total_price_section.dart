import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class TotalPriceSection extends StatelessWidget {
  final String totalPrice;

  const TotalPriceSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Price', style: AppTextStyles.font14w500maincolor),
            SizedBox(height: 4.h),
            Text('with VAT,SD', style: AppTextStyles.font12w400gray),
          ],
        ),
        Text(totalPrice, style: AppTextStyles.font24w700black),
      ],
    );
  }
}
