import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryItemModel categoryItemModel;
  const CategoryItem({super.key, required, required this.categoryItemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE7E8EA)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.ac_unit_outlined,
            size: 24.sp,
            color: const Color.fromARGB(255, 171, 152, 229),
          ),
          SizedBox(width: 8.w),
          Text(
            categoryItemModel.name ?? 'No Name',
            style: AppTextStyles.font15w500Purple.copyWith(
              color: AppColors.darkBlack,
            ),
          ),
        ],
      ),
    );
  }
}
