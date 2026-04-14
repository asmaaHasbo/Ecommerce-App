import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/categories_list_view.dart';

class CategoriesBlocBuilder extends StatelessWidget {
  const CategoriesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeCategoryLoading ||
          current is HomeCategorySuccess ||
          current is HomeCategoryFailure,
      builder: (context, state) {
        log('builder received state: $state');

        if (state is HomeCategoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeCategorySuccess) {
          return CategoriesListView(
            categoriesList: state.categoryModel.categories ?? [],
          );
        } else if (state is HomeCategoryFailure) {
          return setupSnackbarForFailureState(context, state.errMsg);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
