import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/categories_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_resquest_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/products_model.dart';
import 'package:laza_ecommerce_app/features/home/data/repositories/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeInitial());

  //============================ get Categories =================
  Future<void> emitGetCategories() async {
    emit(HomeCategoryLoading());
    log('Loading categories...');

    try {
      final categoryModel = await _homeRepo.getCategories();
      log('Categories loaded: ${categoryModel.categories?.length ?? 0}');
      emit(HomeCategorySuccess(categoryModel: categoryModel));
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      log('Error loading categories: $errorMessage');
      emit(HomeCategoryFailure(errMsg: errorMessage));
    }
  }

  //============================ get product =================
  Future<void> emitGetProducts() async {
    emit(HomeProductLoading());
    log('Loading products...');

    try {
      final productsModel = await _homeRepo.getProducts(
        ProductResquestModel(
          searchTerm: null,
          category: null,
          minPrice: null,
          maxPrice: null,
          isInStock: null,
          sortBy: null,
          sortOrder: null,
          page: 1,
          pageSize: 500,
        ),
      );

      if (productsModel.items != null && productsModel.items!.isNotEmpty) {
        log('Products loaded: ${productsModel.items!.length}');
      } else {
        log('No products found in response');
      }
      
      emit(HomeProductSuccess(productsModel: productsModel));
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      log('Error loading products: $errorMessage');
      emit(HomeProductFailure(errMsg: errorMessage));
    }
  }
}
