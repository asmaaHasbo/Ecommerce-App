import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class RememperMeRow extends StatelessWidget {
  const RememperMeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remember me',
            style: AppTextStyles.font17W500lightGray.copyWith(
              fontSize: 18,
              color: AppColors.darkBlack,
            ),
          ),
          Switch(
            value: true,
            activeColor: Colors.green,
            onChanged: (bool value) {},
          ),
        ],
      ),
    );
  }
}
