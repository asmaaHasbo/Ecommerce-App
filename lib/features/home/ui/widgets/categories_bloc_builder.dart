import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/loading/redacted_helper.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/categories_list_view.dart';

class CategoriesBlocBuilder extends StatelessWidget {
  const CategoriesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام watch عشان نتابع التغييرات في الـ Cubit
    final homeCubit = context.watch<HomeCubit>();
    
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeCategoryLoading ||
          current is HomeCategorySuccess ||
          current is HomeCategoryFailure ||
          current is HomeProductLoading ||
          current is HomeProductSuccess,
      builder: (context, state) {
        log('builder received state: $state');

        final isLoading = state is HomeCategoryLoading;
        final categories = homeCubit.categories;

        if (state is HomeCategoryFailure) {
          return setupSnackbarForFailureState(context, state.errMsg);
        }

        if (categories.isEmpty && !isLoading) {
          return const SizedBox.shrink();
        }

        return CategoriesListView(
          categoriesList: categories,
          isLoading: isLoading,
          selectedCategoryId: homeCubit.selectedCategoryId,
          onCategorySelected: (categoryId) {
            log('Category selected: $categoryId');
            // استدعاء الـ filter method في الـ Cubit
            homeCubit.filterProductsByCategory(categoryId);
          },
        ).redactedHelper(
          context: context,
          isLoading: isLoading,
        );
      },
    );
  }
}

