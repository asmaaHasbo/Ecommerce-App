import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/product_details/data/datasources/product_details_remote.dart';

class ProductDetailsRepo {
  final ProductDetailsRemote _remote;

  ProductDetailsRepo(this._remote);

  Future<ProductItemModel> getProductDetails(String productId) async {
    return await _remote.getProductDetails(productId);
  }
}
