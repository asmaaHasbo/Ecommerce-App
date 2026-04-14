// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

sealed class CartState {}

class CartInitial extends CartState {}

//================================= add states ==============
class AddCartLoading extends CartState {}

class AddCartSuccess extends CartState {
  AddCartResponseModel addCartResponseModel;
  AddCartSuccess({required this.addCartResponseModel});
}

class AddCartFailure extends CartState {
  String errMsg;
  AddCartFailure({required this.errMsg});
}

//================================= get states ==============

class GetCartLoading extends CartState {}

class GetCartSuccess extends CartState {
  CartProductsModel cartProductsModel;
  GetCartSuccess({required this.cartProductsModel});
}

class GetCartFailure extends CartState {
  String errMsg;
  GetCartFailure({required this.errMsg});
}

//====================== delete product ===========
class DelCartSuccess extends CartState {
  DelCartSuccess();
}

class DelCartFailure extends CartState {
  DelCartFailure();
}
