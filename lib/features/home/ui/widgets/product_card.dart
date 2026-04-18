import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/shimmer/image_shimmer.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

class ProductCard extends StatefulWidget {
  final ProductItemModel? product;

  const ProductCard({super.key, this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                //================= Image ===============
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child:
                        widget.product?.imageCover != null &&
                            widget.product!.imageCover!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.product!.imageCover!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => ImageShimmer(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.error_outline,
                                size: 40.sp,
                                color: Colors.grey[300],
                              ),
                            ),
                          )
                        : ImageShimmer(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                  ),
                ),

                //================== Favorite Icon =================
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: BlocBuilder<WishlistCubit, WishlistState>(
                    buildWhen: (previous, current) {
                      // Rebuild on any state that contains product IDs
                      return current is WishlistLoaded ||
                          current is WishlistActionSuccess ||
                          current is WishlistInitial;
                    },
                    builder: (context, state) {
                      final wishlistCubit = context.read<WishlistCubit>();
                      final isInWishlist = widget.product?.id != null
                          ? wishlistCubit.isInWishlist(widget.product!.id!)
                          : false;

                      return GestureDetector(
                        onTap: widget.product?.id != null
                            ? () {
                                if (isInWishlist) {
                                  wishlistCubit.removeFromWishlist(
                                    widget.product!.id!,
                                  );
                                } else {
                                  wishlistCubit.addToWishlist(
                                    widget.product!.id!,
                                  );
                                }
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isInWishlist
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isInWishlist ? Colors.red : Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          //================ Product Name and Price ===============
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product?.title ?? '',
                  style: AppTextStyles.font14w500Black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${widget.product?.price?.toString() ?? ""}',
                  style: AppTextStyles.font14w500Black.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
