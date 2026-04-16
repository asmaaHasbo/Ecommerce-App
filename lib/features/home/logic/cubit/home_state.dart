part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

//===================== HomeCategory ==================
final class HomeCategoryLoading extends HomeState {}

final class HomeCategorySuccess extends HomeState {
  final CategoriesModel categoryModel;
  HomeCategorySuccess({required this.categoryModel});
}

final class HomeCategoryFailure extends HomeState {
  final String errMsg;
  HomeCategoryFailure({required this.errMsg});
}

//===================== Home product ==================
final class HomeProductLoading extends HomeState {}

final class HomeProductSuccess extends HomeState {
  final List<ProductItemModel> products;
  final bool hasMore;

  HomeProductSuccess({
    required this.products,
    required this.hasMore,
  });
}

final class HomeProductFailure extends HomeState {
  final String errMsg;
  HomeProductFailure({required this.errMsg});
}
