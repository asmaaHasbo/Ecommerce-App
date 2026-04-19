import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/categories_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_resquest_model.dart';
import 'package:laza_ecommerce_app/features/home/data/repositories/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeInitial());

  // Pagination state
  List<ProductItemModel> allProducts = [];
  int currentPage = 1;
  int? totalPages;
  bool isLoadingMore = false;

  // Selected category for filtering
  String? selectedCategoryId;

  // Categories cache
  List<CategoryItemModel> categories = [];

  //============================ get Categories =================
  Future<void> getCategories() async {
    emit(HomeCategoryLoading());
    log('Loading categories...');

    try {
      final categoryModel = await _homeRepo.getCategories();
      categories = categoryModel.categories ?? [];
      log('Categories loaded: ${categories.length}');
      emit(HomeCategorySuccess(categoryModel: categoryModel));
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      log('Error loading categories: $errorMessage');
      emit(HomeCategoryFailure(errMsg: errorMessage));
    }
  }

  //============================ get products (initial load) =================
  Future<void> getProducts({bool refresh = false}) async {
    if (refresh) {
      // Reset pagination state
      allProducts.clear();
      currentPage = 1;
      totalPages = null;
      selectedCategoryId = null;
    }

    emit(HomeProductLoading());
    log('Loading products page $currentPage...');

    try {
      final productsModel = await _homeRepo.getProducts(
        ProductResquestModel(
          searchTerm: null,
          category: selectedCategoryId,
          minPrice: null,
          maxPrice: null,
          isInStock: null,
          sortBy: null,
          sortOrder: null,
          page: currentPage,
          limit: 40,
        ),
      );

      if (productsModel.data != null) {
        allProducts.addAll(productsModel.data!);
        totalPages = productsModel.metadata?.numberOfPages;
        log(
          'Products loaded: ${productsModel.data!.length}, Total pages: $totalPages',
        );
      }

      emit(
        HomeProductSuccess(
          products: List.from(allProducts),
          hasMore: currentPage < (totalPages ?? 0),
        ),
      );
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      log('Error loading products: $errorMessage');
      emit(HomeProductFailure(errMsg: errorMessage));
    }
  }

  //============================ load more products =================
  Future<void> loadMoreProducts() async {
    // Prevent multiple simultaneous loads
    if (isLoadingMore) return;

    // Check if there are more pages
    if (totalPages != null && currentPage >= totalPages!) {
      log('No more pages to load');
      return;
    }

    isLoadingMore = true;
    currentPage++;
    log('Loading more products, page $currentPage...');

    try {
      final productsModel = await _homeRepo.getProducts(
        ProductResquestModel(
          searchTerm: null,
          category: selectedCategoryId,
          minPrice: null,
          maxPrice: null,
          isInStock: null,
          sortBy: null,
          sortOrder: null,
          page: currentPage,
          limit: 40,
        ),
      );

      if (productsModel.data != null) {
        allProducts.addAll(productsModel.data!);
        totalPages = productsModel.metadata?.numberOfPages;
        log('More products loaded: ${productsModel.data!.length}');
      }

      emit(
        HomeProductSuccess(
          products: List.from(allProducts),
          hasMore: currentPage < (totalPages ?? 0),
        ),
      );
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      log('Error loading more products: $errorMessage');
      // Don't emit failure, just log the error
      currentPage--; // Revert page increment
    } finally {
      isLoadingMore = false;
    }
  }

  //============================ filter products by category =================
  Future<void> filterProductsByCategory(String? categoryId) async {
    // Update selected category
    selectedCategoryId = categoryId;
    
    log('Filtering products by category: $categoryId');

    // Reset pagination
    allProducts.clear();
    currentPage = 1;
    totalPages = null;

    // Reload products with new filter
    await getProducts();
  }

  //============================ search products (client-side) =================
  void searchProducts(String query) {
    log('Searching products with query: "$query"');

    // If query is empty, show all products
    if (query.trim().isEmpty) {
      emit(
        HomeProductSuccess(
          products: List.from(allProducts),
          hasMore: currentPage < (totalPages ?? 0),
        ),
      );
      return;
    }

    // Filter products locally
    final lowerQuery = query.toLowerCase().trim();
    final filteredProducts = allProducts.where((product) {
      final title = product.title?.toLowerCase() ?? '';
      final description = product.description?.toLowerCase() ?? '';
      final brand = product.brand?.name?.toLowerCase() ?? '';
      final category = product.category?.name?.toLowerCase() ?? '';

      return title.contains(lowerQuery) ||
          description.contains(lowerQuery) ||
          brand.contains(lowerQuery) ||
          category.contains(lowerQuery);
    }).toList();

    log('Search results: ${filteredProducts.length} products found');

    // Emit search results state
    emit(
      HomeSearchResults(
        results: filteredProducts,
        query: query,
        hasMore: false, // No pagination for search results
      ),
    );
  }
}
