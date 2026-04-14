import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_travel, color: AppColors.iconGray),
          Text('Your Cart is empty', style: AppTextStyles.font17w600Black),
          Text(
            'Add items you like to your cart',
            style: AppTextStyles.font14w500Black,
          ),
        ],
      ),
    );
  }
}
