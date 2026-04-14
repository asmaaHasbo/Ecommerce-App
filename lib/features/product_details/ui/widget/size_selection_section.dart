import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class SizeSelectionSection extends StatelessWidget {
  final List<String> sizes;
  final String? selectedSize;
  final Function(String) onSizeSelected;

  const SizeSelectionSection({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Size', style: AppTextStyles.font16w600black),
            Text('Size Guide', style: AppTextStyles.font14w400gray),
          ],
        ),
        SizedBox(height: 16.h),
        // FIXED: استخدام Wrap بدلاً من Row لتجنب Overflow
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: sizes.map((size) {
            final isSelected = selectedSize == size;
            return GestureDetector(
              onTap: () => onSizeSelected(size),
              child: Container(
                width: 60.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2B2B2B)
                      : const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  size,
                  style: AppTextStyles.font14w500maincolor.copyWith(
                    color: isSelected ? Colors.white : const Color(0xFF2B2B2B),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
