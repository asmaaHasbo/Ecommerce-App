import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/category_item.dart';

class CategoriesListView extends StatelessWidget {
  final List<CategoryItemModel> categoriesList;

  const CategoriesListView({required this.categoriesList, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories', style: AppTextStyles.font17w600Black),
              Text('View All', style: AppTextStyles.font15w500Purple),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 60.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return CategoryItem(categoryItemModel: categoriesList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
