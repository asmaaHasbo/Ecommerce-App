import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

class WishlistIconButton extends StatelessWidget {
  final String productId;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;

  const WishlistIconButton({
    super.key,
    required this.productId,
    this.size,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      buildWhen: (previous, current) {
        // Rebuild when wishlist is loaded or action succeeds
        return current is WishlistLoaded ||
            current is WishlistActionSuccess;
      },
      builder: (context, state) {
        final wishlistCubit = context.read<WishlistCubit>();
        final isInWishlist = wishlistCubit.isInWishlist(productId);

        return GestureDetector(
          onTap: () {
            if (isInWishlist) {
              wishlistCubit.removeFromWishlist(productId);
            } else {
              wishlistCubit.addToWishlist(productId);
            }
          },
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist
                  ? (activeColor ?? AppColors.orange)
                  : (inactiveColor ?? AppColors.lightGray),
              size: size ?? 20.sp,
            ),
          ),
        );
      },
    );
  }
}
