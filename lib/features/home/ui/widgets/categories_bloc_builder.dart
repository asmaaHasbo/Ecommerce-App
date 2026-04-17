import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/loading/redacted_helper.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';
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

        final isLoading = state is HomeCategoryLoading;
        
        // Dummy categories for loading state
        final categoriesToShow = isLoading
            ? List.generate(5, (index) => _getDummyCategory())
            : (state is HomeCategorySuccess 
                ? state.categoryModel.categories ?? [] 
                : <CategoryItemModel>[]);

        if (state is HomeCategoryFailure) {
          return setupSnackbarForFailureState(context, state.errMsg);
        }

        if (categoriesToShow.isEmpty && !isLoading) {
          return const SizedBox.shrink();
        }

        return CategoriesListView(
          categoriesList: categoriesToShow,
        ).redactedHelper(
          context: context,
          isLoading: isLoading,
        );
      },
    );
  }

  // Dummy category for loading state
  CategoryItemModel _getDummyCategory() {
    return CategoryItemModel(
      id: 'loading',
      name: 'Category',
      image: '',
    );
  }
}

