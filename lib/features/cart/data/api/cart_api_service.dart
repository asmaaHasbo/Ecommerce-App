import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_request_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_response_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_products_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'cart_api_service.g.dart';

@RestApi(baseUrl: ApiEndPontis.baseUrl)
abstract class CartApiService {
  factory CartApiService(Dio dio) = _CartApiService;

  //======================= addProduct to cart ===============
  @POST(ApiEndPontis.addProductToCart)
  Future<AddCartResponseModel> addProductToCart(
    @Body() AddCartRequestModel addCartRequestModel,
  );

  //======================= get Product to cart ===============
  @GET(ApiEndPontis.getCartProduct)
  Future<CartProductsModel> getCartProducts();

  //======================= del Product to cart ===============
  @DELETE(ApiEndPontis.deleteProduct)
  Future deleteProduct(
    @Path('id') String productId, // هنا بنحدد ان الـ id هيتحط في الـ URL
    @Body() Map<String, dynamic> body,
  );
}
