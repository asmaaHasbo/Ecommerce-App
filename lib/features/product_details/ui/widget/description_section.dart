import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class DescriptionSection extends StatelessWidget {
  final String? description;

  const DescriptionSection({super.key, this.description});

  String _formatDescription(String desc) {
    return desc.replaceAll('\t', ': ').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTextStyles.font16w600black),
        SizedBox(height: 10.h),
        Text(
          _formatDescription(description ?? 'No description available'),
          style: AppTextStyles.font14w400gray,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
