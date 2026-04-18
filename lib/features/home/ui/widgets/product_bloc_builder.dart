import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/product_grid.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

class ProductBlocBuilder extends StatefulWidget {
  const ProductBlocBuilder({super.key});

  @override
  State<ProductBlocBuilder> createState() => _ProductBlocBuilderState();
}

class _ProductBlocBuilderState extends State<ProductBlocBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeCubit>().loadMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistCubit, WishlistState>(
      listener: (context, wishlistState) {
        // Rebuild when wishlist changes
        if (wishlistState is WishlistLoaded ||
            wishlistState is WishlistActionSuccess) {
          setState(() {});
        }
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (previous, current) => current is HomeProductFailure,
        listener: (context, state) {
          if (state is HomeProductFailure) {
            setupSnackbarForFailureState(context, state.errMsg);
          }
        },
        buildWhen: (previous, current) =>
            current is HomeProductLoading ||
            current is HomeProductSuccess ||
            current is HomeProductFailure,
        builder: (context, state) {
          log('builder received state: $state');

          final isLoading = state is HomeProductLoading;
          final products = state is HomeProductSuccess
              ? state.products
              : <ProductItemModel>[];

          if (products.isEmpty && !isLoading) {
            return const SizedBox.shrink();
          }

          return ProductGrid(
            products: products,
            scrollController: _scrollController,
            hasMore: state is HomeProductSuccess ? state.hasMore : false,
            isLoading: isLoading,
          );
        },
      ),
    );
  }
}
