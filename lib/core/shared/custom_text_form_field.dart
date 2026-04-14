import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isTextObsecure,
    this.suffixIcon,
    required this.controller,
    required this.validator,
    this.lableText,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final String hintText;
  final String? lableText;
  final bool? isTextObsecure;
  // final VoidCallback validator;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lableText != null) ...[
            Text(
              lableText!,
              style: AppTextStyles.font14W500lightGray.copyWith(fontSize: 15),
            ),
          ],
          SizedBox(height: 7.h),
          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: isTextObsecure ?? false,
            decoration: InputDecoration(
              isDense: true, // يقلل الارتفاع والمساحات الداخلية
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 18.0.h,
              ),
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              filled: true,
              hintText: hintText,
              hintStyle: AppTextStyles.font14W500lightGray,
              suffixIcon: suffixIcon,

              //------------------------------ borders -------------------------
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0.w),
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0.w),
                borderSide: BorderSide(color: Colors.blue, width: 1.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0.w),
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                  width: 1.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0.w),
                borderSide: BorderSide(color: Colors.red, width: 1.w),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0.w),
                borderSide: BorderSide(color: Colors.red, width: 1.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
