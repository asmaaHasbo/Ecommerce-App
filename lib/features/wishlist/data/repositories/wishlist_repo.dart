import 'package:laza_ecommerce_app/features/wishlist/data/datasources/wishlist_remote.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/models/remove_wishlist_response_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/models/wishlist_response_model.dart';

class WishlistRepo {
  final WishlistRemote _remote;

  WishlistRepo(this._remote);

  Future<WishlistResponseModel> addToWishlist(String productId) async {
    return await _remote.addToWishlist(productId);
  }

  Future<WishlistResponseModel> getWishlist() async {
    return await _remote.getWishlist();
  }

  Future<RemoveWishlistResponseModel> removeFromWishlist(String productId) async {
    return await _remote.removeFromWishlist(productId);
  }
}
