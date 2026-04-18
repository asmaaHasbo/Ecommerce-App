import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/repositories/wishlist_repo.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepo _repo;

  WishlistCubit(this._repo) : super(WishlistInitial());

  List<String> wishlistProductIds = [];
  List<ProductItemModel> wishlistProducts = [];

  //============================ get wishlist =================
  Future<void> getWishlist() async {

    emit(WishlistLoading());

    try {
      final response = await _repo.getWishlist();
      wishlistProducts = response.data ?? [];
      wishlistProductIds = response.getProductIds();
      emit(WishlistLoaded(wishlistProductIds));
    } catch (e) {
      emit(WishlistError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  //============================ add to wishlist =================
  Future<void> addToWishlist(String productId) async {
    emit(WishlistActionLoading());

    try {
      final response = await _repo.addToWishlist(productId);
      wishlistProducts = response.data ?? [];
      wishlistProductIds = response.getProductIds();
      
      // Emit success message first
      emit(WishlistActionSuccess(
        message: response.message ?? 'Product added to wishlist',
        productIds: wishlistProductIds,
      ));
      
      // Then immediately emit loaded state with updated list
      emit(WishlistLoaded(wishlistProductIds));
    } catch (e) {
      emit(WishlistActionError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    emit(WishlistActionLoading());

    try {
      final response = await _repo.removeFromWishlist(productId);
      
      // Update the wishlist IDs from the response
      wishlistProductIds = response.data ?? [];
      
      // Remove the product from the local list
      wishlistProducts.removeWhere((product) => product.id == productId);
      
      // Emit success message first
      emit(WishlistActionSuccess(
        message: response.message ?? 'Product removed from wishlist',
        productIds: wishlistProductIds,
      ));
      
      // Then immediately emit loaded state with updated list
      emit(WishlistLoaded(wishlistProductIds));
    } catch (e) {
      emit(WishlistActionError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  bool isInWishlist(String productId) {
    return wishlistProductIds.contains(productId);
  }
}
