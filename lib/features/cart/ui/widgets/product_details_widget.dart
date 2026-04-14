import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_item.dart';

class ProductDetailsWidget extends StatelessWidget {
  
 final CartItemModel cartItem;
  const ProductDetailsWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            cartItem.productName!,
            style: AppTextStyles.font16w600black,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
       Text(
          '\$${cartItem.totalPrice} (-\$${cartItem.discountPercentage} Tax)',
          style: AppTextStyles.font14w500maincolor,
        ),
      ],
    );
  }
}
