import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductItemModel product;

  ProductDetailsSuccess(this.product);
}

class ProductDetailsFailure extends ProductDetailsState {
  final String errMsg;

  ProductDetailsFailure(this.errMsg);
}
