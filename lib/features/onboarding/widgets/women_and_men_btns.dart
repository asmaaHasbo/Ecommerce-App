import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helper/constant.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/helper/shared_preferences.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/custom_elevated_btn.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class WomenAndMenBtn extends StatelessWidget {
  const WomenAndMenBtn({super.key});

  Future<void> _handleSelection(BuildContext context, String gender) async {
    // حفظ إن المستخدم شاف الـ onboarding
    await SharedPrefHelper.setData(SharedPrefKeys.hasSeenOnboarding, true);
    
    // ممكن نحفظ اختيار الـ gender لو محتاجينه
    // await SharedPrefHelper.setData('selectedGender', gender);
    
    if (context.mounted) {
      context.pushReplacementNamed(Routes.getStartedScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // زر Men
        Expanded(
          child: CustomElevatedBtn(
            height: 60.h,
            backgroundColor: AppColors.lighterGray,
            btnName: 'Men',
            textStyle: AppTextStyles.font17W500lightGray.copyWith(
              color: Colors.black54,
            ),
            onPressed: () => _handleSelection(context, 'Men'),
          ),
        ),
        SizedBox(width: 16.w),

        // زر Women
        Expanded(
          child: CustomElevatedBtn(
            height: 60.h,
            backgroundColor: AppColors.mainColor,
            btnName: 'Women',
            textStyle: AppTextStyles.font17W500lightGray.copyWith(
              color: Colors.white,
            ),
            onPressed: () => _handleSelection(context, 'Women'),
          ),
        ),
      ],
    );
  }
}
