import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddCartSuccess) {
          setupSnackBarForSuccessState(context, state.message);
        } else if (state is AddCartFailure) {
          if (!state.errMsg.contains('already in cart')) {
            setupSnackbarForFailureState(context, state.errMsg);
          }
        }
      },
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final isLoading = state is AddCartLoading;
        final isInCart = cartCubit.isProductInCart(productId);
        final isDisabled = isLoading || isInCart;

        return SizedBox(
          width: double.infinity,
          height: 62,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isInCart ? Colors.grey : AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: isDisabled
                ? null
                : () {
                    log('Adding product to cart: $productId');
                    cartCubit.addProductToCart(productId: productId);
                  },
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    isInCart ? 'Already in Cart' : 'Add to Cart',
                    style: AppTextStyles.font17W600white.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
