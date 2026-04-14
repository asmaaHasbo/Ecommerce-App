import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/product_grid.dart';

class ProductBlocBuilder extends StatelessWidget {
  const ProductBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeProductLoading ||
          current is HomeProductSuccess ||
          current is HomeProductFailure,
      builder: (context, state) {
        log('builder received state: $state');
        if (state is HomeProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeProductSuccess) {
          return ProductGrid(products: state.productsModel.items ?? []);
        } else if (state is HomeProductFailure) {
          return setupSnackbarForFailureState(context, state.errMsg);
        } else {
          log('errppp');
          return SizedBox.shrink();
        }
      },
    );
  }
}
