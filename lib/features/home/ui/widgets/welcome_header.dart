import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello',
            style: AppTextStyles.font24w700Black,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 4.h),
          Text('Welcome to Laza Store.', style: AppTextStyles.font15W400lightGray),
        ],
      ),
    );
  }
}
