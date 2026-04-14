import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_item.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/cart_item_widget.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final void Function(String) onRemove;

  const CartItemsList({
    super.key,
    required this.cartItems,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return CartItemWidget(
                cartItemModel: cartItems[index],

                onRemove: onRemove,
              );
            },
          ),
        ),
      ],
    );
  }
}
