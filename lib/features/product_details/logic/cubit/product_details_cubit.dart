import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/product_details/data/repositories/product_details_repo.dart';
import 'package:laza_ecommerce_app/features/product_details/logic/cubit/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo _repo;

  ProductDetailsCubit(this._repo) : super(ProductDetailsInitial());

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await _repo.getProductDetails(productId);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
