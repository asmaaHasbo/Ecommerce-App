part of 'cart_cubit.dart';

sealed class CartState {}

class CartInitial extends CartState {}

//================================= add states ==============
class AddCartLoading extends CartState {}

class AddCartSuccess extends CartState {
  final AddCartResponseModel addCartResponseModel;
  final String message;
  AddCartSuccess({
    required this.addCartResponseModel,
    required this.message,
  });
}

class AddCartFailure extends CartState {
  final String errMsg;
  AddCartFailure({required this.errMsg});
}

//================================= get states ==============

class GetCartLoading extends CartState {}

class GetCartSuccess extends CartState {
  final CartProductsModel cartProductsModel;
  GetCartSuccess({required this.cartProductsModel});
}

class GetCartFailure extends CartState {
  final String errMsg;
  GetCartFailure({required this.errMsg});
}

//====================== update quantity ===========
class UpdateCartSuccess extends CartState {
  final CartProductsModel cartProductsModel;
  UpdateCartSuccess({required this.cartProductsModel});
}

class UpdateCartFailure extends CartState {
  final String errMsg;
  UpdateCartFailure({required this.errMsg});
}

//====================== delete product ===========
class DelCartSuccess extends CartState {
  final CartProductsModel cartProductsModel;
  final String message;
  DelCartSuccess({
    required this.cartProductsModel,
    required this.message,
  });
}

class DelCartFailure extends CartState {
  final String errMsg;
  DelCartFailure({required this.errMsg});
}
