import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/quantity_button.dart';

class CartCounter extends StatelessWidget {
  final int quantity;
  final String productId;

  const CartCounter({
    super.key,
    required this.quantity,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuantityButton(
          icon: Icons.remove,
          onTap: () {
            if (quantity > 1) {
              context.read<CartCubit>().updateCartQuantity(
                    productId: productId,
                    count: quantity - 1,
                  );
            }
          },
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 30.w,
          child: Center(
            child: Text(
              quantity.toString(),
              style: AppTextStyles.font17W600white.copyWith(
                color: AppColors.mainColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        QuantityButton(
          icon: Icons.add,
          onTap: () {
            context.read<CartCubit>().updateCartQuantity(
                  productId: productId,
                  count: quantity + 1,
                );
          },
        ),
      ],
    );
  }
}
