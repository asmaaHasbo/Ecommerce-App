// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/shimmer/image_shimmer.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_item_model.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/counter.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/delete_btn.dart';
import 'product_image_widget.dart';
import 'product_details_widget.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel? cartItemModel;

  const CartItemWidget({
    super.key,
    this.cartItemModel,
  });

  @override
  Widget build(BuildContext context) {
    if (cartItemModel != null) {
      log('Cart Item - itemId: ${cartItemModel!.itemId}, productId: ${cartItemModel!.productId}');
    }
    
    return Container(
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
    
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          cartItemModel?.productCoverUrl != null
              ? ProductImageWidget(imageUrl: cartItemModel!.productCoverUrl!)
              : ImageShimmer(
                  width: 80.w,
                  height: 80.h,
                  borderRadius: BorderRadius.circular(8.r),
                ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailsWidget(cartItem: cartItemModel),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (cartItemModel != null)
                      CartCounter(
                        quantity: cartItemModel!.quantity ?? 1,
                        productId: cartItemModel!.productId ?? '',
                      )
                    else
                      Container(
                        width: 100.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    if (cartItemModel != null)
                      DeleteButton(itemtId: cartItemModel!.productId ?? '')
                    else
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
