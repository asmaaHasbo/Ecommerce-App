import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTextStyles.font16w600black),
        SizedBox(height: 12.h),
        RichText(
          text: TextSpan(
            text: description,
            style: AppTextStyles.font14w400gray,
            children: [
              TextSpan(
                text: ' Read More...',
                style: AppTextStyles.font14w500maincolor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
