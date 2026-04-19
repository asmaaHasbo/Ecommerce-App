// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/shimmer/image_shimmer.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

class WishlistItemCard extends StatelessWidget {
  final ProductItemModel? product;

  const WishlistItemCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      // margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              _buildProductImage(),
              SizedBox(width: 16.w),
              Expanded(child: _buildProductInfo()),
              SizedBox(width: 50.w),
            ],
          ),
          _buildRemoveButton(context),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 110.w,
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
        child: product?.imageCover != null && product!.imageCover!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: product!.imageCover!,
                fit: BoxFit.cover,
                placeholder: (context, url) => ImageShimmer(
                  width: 110.w,
                  height: 140.h,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.lighterGray,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.lightGray,
                    size: 40.sp,
                  ),
                ),
              )
            : ImageShimmer(
                width: 110.w,
                height: 140.h,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
              ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product?.title ?? '',
                  style: AppTextStyles.font16w600black.copyWith(
                    fontSize: 14.sp,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (product?.brand?.name != null) ...[
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lighterGray,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      product!.brand!.name!,
                      style: AppTextStyles.font12w400gray.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.lightGray,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.mainColor.withOpacity(0.15),
                  AppColors.mainColor.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '\$${product?.price ?? ""}',
              style: AppTextStyles.font17w600Black.copyWith(
                color: AppColors.mainColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return Positioned(
      top: 8.h,
      right: 8.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: product?.id != null
              ? () {
                  log('Remove from wishlist: ${product!.id}');
                  context.read<WishlistCubit>().removeFromWishlist(
                    product!.id!,
                  );
                }
              : null,
          icon: Icon(Icons.favorite, color: AppColors.orange, size: 22.sp),
          style: IconButton.styleFrom(
            padding: EdgeInsets.all(8.w),
            minimumSize: Size(36.w, 36.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}
