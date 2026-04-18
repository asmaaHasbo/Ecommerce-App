import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
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
    context.read<CartCubit>().getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(child: Text('Cart')),
      ),
      body: const SafeArea(child: CartContent()),
    );
  }
}

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<CartCubit>().getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is DelCartSuccess) {
          setupSnackBarForSuccessState(context, state.message);
        } else if (state is DelCartFailure) {
          setupSnackbarForFailureState(context, state.errMsg);
        } else if (state is UpdateCartFailure) {
          setupSnackbarForFailureState(context, state.errMsg);
        } else if (state is AddCartSuccess) {
          setupSnackBarForSuccessState(context, state.message);
        } else if (state is AddCartFailure) {
          setupSnackbarForFailureState(context, state.errMsg);
        }
      },
      builder: (context, state) {
        final isLoading = state is GetCartLoading;
        
        if (state is GetCartFailure) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(child: Text(state.errMsg)),
              ),
            ),
          );
        }
        
        // Get cart data MODEL from state or use empty model for loading
        final cartData = state is GetCartSuccess
            ? state.cartProductsModel
            : state is DelCartSuccess
                ? state.cartProductsModel
                : state is UpdateCartSuccess
                    ? state.cartProductsModel
                    : null;

        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: CartItemsOnSuccess(
            cartProductsModel: cartData,
            isLoading: isLoading,
          ),
        );
      },
    );
  }
}
