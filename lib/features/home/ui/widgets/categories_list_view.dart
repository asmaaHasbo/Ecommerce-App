import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/shimmer/image_shimmer.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';

class CategoriesListView extends StatefulWidget {
  final List<CategoryItemModel> categoriesList;

  const CategoriesListView({required this.categoriesList, super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  String selectedCategoryId = 'all';

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
            ],
          ),
          SizedBox(height: 16.h),

          SizedBox(
            height: 60.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categoriesList.length + 1, // +1 للـ "All"
              itemBuilder: (context, index) {
                // أول عنصر هو "All"
                if (index == 0) {
                  return _buildCategoryChip(
                    id: 'all',
                    name: 'All',
                    imageUrl: null, // مفيش صورة للـ "All"
                    isSelected: selectedCategoryId == 'all',
                  );
                }

                // باقي الـ categories
                final category = widget.categoriesList[index - 1];
                return _buildCategoryChip(
                  id: category.id ?? '',
                  name: category.name ?? 'No Name',
                  imageUrl: category.image, // صورة الـ category
                  isSelected: selectedCategoryId == category.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String id,
    required String name,
    required String? imageUrl,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryId = id;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColors.mainColor : const Color(0xFFE7E8EA),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // عرض الصورة لو موجودة (كل الـ categories ماعدا "All")
            if (imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ImageShimmer(
                    width: 24.w,
                    height: 24.h,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.category_outlined,
                    size: 24.sp,
                    color: isSelected ? Colors.white : AppColors.mainColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],

            // اسم الـ category
            Text(
              name,
              style: AppTextStyles.font15w500Purple.copyWith(
                color: isSelected ? Colors.white : AppColors.darkBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
