import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/custom_elevated_btn.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class ScreensBottomBtn extends StatelessWidget {
  const ScreensBottomBtn({
    super.key,
    required this.onPressed,
    required this.btnName,
  });
  final String btnName;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomElevatedBtn(
        width: double.infinity,
        height: 56.h,
        backgroundColor: AppColors.mainColor,
        btnName: btnName,
        raduis: 10.r,
        textStyle: AppTextStyles.font17W600white.copyWith(
          fontWeight: FontWeight.w500,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
