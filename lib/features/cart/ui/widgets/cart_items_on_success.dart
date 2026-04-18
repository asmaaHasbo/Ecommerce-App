import 'package:flutter/widgets.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_products_model.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/cart_items_list_view.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/empty_cart.dart';

class CartItemsOnSuccess extends StatelessWidget {
  final CartProductsModel? cartProductsModel;
  final bool isLoading;

  const CartItemsOnSuccess({
    super.key,
    this.cartProductsModel,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // During loading, show skeleton with empty list
    if (isLoading) {
      return const CartItemsList(
        cartItems: [],
        totalPrice: 0,
        isLoading: true,
      );
    }
    
    final cartItems = cartProductsModel?.cartItems ?? [];
    if (cartItems.isEmpty) {
      return const EmptyCart();
    }
    
    return CartItemsList(
      cartItems: cartItems,
      totalPrice: cartProductsModel?.totalCartPrice ?? 0,
      isLoading: false,
    );
  }
}
