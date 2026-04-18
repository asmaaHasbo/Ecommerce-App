import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/shimmer/image_shimmer.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';

class CategoriesListView extends StatefulWidget {
  final List<CategoryItemModel> categoriesList;
  final bool isLoading;
  final String? selectedCategoryId;
  final Function(String?)? onCategorySelected;

  const CategoriesListView({
    required this.categoriesList,
    this.isLoading = false,
    this.selectedCategoryId,
    this.onCategorySelected,
    super.key,
  });

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  @override
  Widget build(BuildContext context) {
    // استخدام الـ selectedCategoryId من الـ parent أو default value
    final selectedId = widget.selectedCategoryId ?? 'all';

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
              itemCount: widget.isLoading ? 5 : widget.categoriesList.length + 1,
              itemBuilder: (context, index) {
                if (widget.isLoading) {
                  return _buildCategoryChip(
                    id: null,
                    name: '',
                    imageUrl: '',
                    isSelected: false,
                  );
                }

                // أول عنصر هو "All"
                if (index == 0) {
                  return _buildCategoryChip(
                    id: 'all',
                    name: 'All',
                    imageUrl: null,
                    isSelected: selectedId == 'all',
                  );
                }

                // باقي الـ categories
                final category = widget.categoriesList[index - 1];
                return _buildCategoryChip(
                  id: category.id,
                  name: category.name ?? '',
                  imageUrl: category.image,
                  isSelected: selectedId == category.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String? id,
    required String name,
    required String? imageUrl,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: id != null
          ? () {
              // استدعاء الـ callback بدل setState
              widget.onCategorySelected?.call(id == 'all' ? null : id);
            }
          : null,
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
