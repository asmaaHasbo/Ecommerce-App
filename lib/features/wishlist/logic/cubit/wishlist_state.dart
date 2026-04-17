part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final List<String> productIds;
  WishlistLoaded(this.productIds);
}

final class WishlistError extends WishlistState {
  final String errorMessage;
  WishlistError(this.errorMessage);
}

final class WishlistActionLoading extends WishlistState {}

final class WishlistActionSuccess extends WishlistState {
  final String message;
  final List<String> productIds;
  WishlistActionSuccess({required this.message, required this.productIds});
}

final class WishlistActionError extends WishlistState {
  final String errorMessage;
  WishlistActionError(this.errorMessage);
}
