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
    try {
      // Update local state immediately for instant UI feedback
      wishlistProductIds.add(productId);
      emit(WishlistLoaded(wishlistProductIds));
      
      final response = await _repo.addToWishlist(productId);
      
      // Update with server response (IDs only)
      wishlistProductIds = response.getProductIds();
      
      // Emit success message
      emit(WishlistActionSuccess(
        message: response.message ?? 'Product added to wishlist',
        productIds: wishlistProductIds,
      ));
      
      // Emit loaded state with server response
      emit(WishlistLoaded(wishlistProductIds));
    } catch (e) {
      // Revert local change on error
      wishlistProductIds.remove(productId);
      emit(WishlistLoaded(wishlistProductIds));
      emit(WishlistActionError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      // Update local state immediately for instant UI feedback
      wishlistProductIds.remove(productId);
      wishlistProducts.removeWhere((product) => product.id == productId);
      emit(WishlistLoaded(wishlistProductIds));
      
      final response = await _repo.removeFromWishlist(productId);
      
      // Update the wishlist IDs from the response
      wishlistProductIds = response.data ?? [];
      
      // Emit success message
      emit(WishlistActionSuccess(
        message: response.message ?? 'Product removed from wishlist',
        productIds: wishlistProductIds,
      ));
      
      // Emit loaded state with server response
      emit(WishlistLoaded(wishlistProductIds));
    } catch (e) {
      // Revert local change on error
      wishlistProductIds.add(productId);
      emit(WishlistLoaded(wishlistProductIds));
      emit(WishlistActionError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  bool isInWishlist(String productId) {
    return wishlistProductIds.contains(productId);
  }
}
