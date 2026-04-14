import 'package:laza_ecommerce_app/features/home/data/datasources/home_remote.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/categories_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_resquest_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/products_model.dart';

class HomeRepo {
  final HomeRemote _remote;

  HomeRepo(this._remote);

  Future<CategoriesModel> getCategories() async {
    return await _remote.getCategories();
  }

  Future<ProductsModel> getProducts(
    ProductResquestModel productResquestModel,
  ) async {
    return await _remote.getProducts(productResquestModel);
  }
}
