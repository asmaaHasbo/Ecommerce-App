import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/cart_items_on_success.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).emitGetProductsCartStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(child: Text('Cart')),
      ),
      body: SafeArea(child: const CartContent()),
    );
  }
}

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        log('Cart state is $state');
        if (state is GetCartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCartFailure) {
          return Center(child: Text(state.errMsg));
        } else if (state is GetCartSuccess) {
          return CartItemsOnSuccess(cartProductsModel: state.cartProductsModel);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
