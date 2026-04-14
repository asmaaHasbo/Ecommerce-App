import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Product added to cart successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AddCartFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Error: ${state.errMsg}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddCartLoading ? true : false;

        return SizedBox(
          width: double.infinity,
          height: 62,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
                    log('product addProductToCart');
                    log(productId);
                    context.read<CartCubit>().emitAddProductsToCartStates(
                      productId: productId,
                    );
                  },
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Add to Cart',
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
