import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/onboarding/widgets/skip_btn.dart';
import 'package:laza_ecommerce_app/features/onboarding/widgets/women_and_men_btns.dart';

class OnboardingContainer extends StatelessWidget {
  const OnboardingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // العنوان الرئيسي
          Text(
            'Look Good, Feel Good',
            style: AppTextStyles.font25W600darkBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),

          // الوصف
          Text(
            'Create your individual & unique style and\nlook amazing everyday.',
            style: AppTextStyles.font15W400lightGray,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),

          // أزرار Men & Women
          WomenAndMenBtn(),
          SizedBox(height: 10.h),

          // زر Skip
          SkipBtn(),
        ],
      ),
    );
  }
}
