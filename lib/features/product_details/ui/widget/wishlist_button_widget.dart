import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

class WishlistButtonWidget extends StatelessWidget {
  final String productId;

  const WishlistButtonWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
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
            width: 45.w,
            height: 45.h,
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
              color: isInWishlist ? Colors.red : const Color(0xFF2B2B2B),
              size: 22.sp,
            ),
          ),
        );
      },
    );
  }
}
