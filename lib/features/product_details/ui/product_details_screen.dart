import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/di/dependency_injection.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/product_details/logic/cubit/product_details_cubit.dart';
import 'package:laza_ecommerce_app/features/product_details/logic/cubit/product_details_state.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/screens/all_reviews_screen.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/add_to_cart_button.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/brand_and_sold_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/description_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/out_of_stock_indicator.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/product_image_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/product_images_list.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/product_info_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/review_section.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:redacted/redacted.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductItemModel? product;
  final String? productId;

  const ProductDetailsScreen({
    super.key,
    this.product,
    this.productId,
  }) : assert(product != null || productId != null,
            'Either product or productId must be provided');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProductDetailsCubit>()),
        BlocProvider(create: (_) => getIt<WishlistCubit>()..getWishlist()),
      ],
      child: _ProductDetailsContent(
        initialProduct: product,
        productId: productId ?? product?.id ?? '',
      ),
    );
  }
}

class _ProductDetailsContent extends StatefulWidget {
  final ProductItemModel? initialProduct;
  final String productId;

  const _ProductDetailsContent({
    required this.initialProduct,
    required this.productId,
  });

  @override
  State<_ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<_ProductDetailsContent> {
  int selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getCartProducts();
      // Always fetch full product details to get reviews
      context.read<ProductDetailsCubit>().getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final bool isLoading = state is ProductDetailsLoading;
          
          if (state is ProductDetailsFailure) {
            return _buildError(state.errMsg);
          }

          final product = state is ProductDetailsSuccess
              ? state.product
              : widget.initialProduct;

          return _buildProductDetails(product, isLoading);
        },
      ),
    );
  }

  Widget _buildProductDetails(ProductItemModel? product, bool isLoading) {
    log('from product detail product id ${product?.id}');

    final List<String> productImages = [
      if (product?.imageCover != null) product!.imageCover!,
      if (product?.images != null) ...product!.images!,
    ];

    final int maxQuantity = product?.quantity ?? 0;
    final bool isOutOfStock = maxQuantity == 0 && !isLoading;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProductImageSection(
                  mainImage: productImages.isNotEmpty
                      ? productImages[selectedImageIndex]
                      : product?.imageCover ?? '',
                  allImages: productImages,
                  currentIndex: selectedImageIndex,
                  productId: product?.id ?? '',
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductInfoSection(
                          category: product?.category?.name,
                          name: product?.title,
                          price: product?.price != null ? '\$${product!.price}' : null,
                          rating: product?.ratingsAverage,
                          reviewsCount: product?.ratingsQuantity,
                        ).redacted(context: context, redact: isLoading),
                        SizedBox(height: 12.h),
                        BrandAndSoldSection(
                          brandName: product?.brand?.name,
                          soldCount: product?.sold,
                        ).redacted(context: context, redact: isLoading),
                        if (isOutOfStock) ...[
                          SizedBox(height: 16.h),
                          const OutOfStockIndicator(),
                        ],
                        SizedBox(height: 20.h),
                        if (productImages.length > 1 && !isLoading)
                          ProductImagesList(
                            images: productImages,
                            selectedIndex: selectedImageIndex,
                            onImageSelected: (index) {
                              setState(() {
                                selectedImageIndex = index;
                              });
                            },
                          ),
                        if (productImages.length > 1 && !isLoading) SizedBox(height: 24.h),
                        DescriptionSection(
                          description: product?.description,
                        ).redacted(context: context, redact: isLoading),
                        SizedBox(height: 24.h),
                        if (!isLoading)
                          ReviewSection(
                            reviews: product?.reviews,
                            onViewAllTap: () {
                              if (product?.reviews != null &&
                                  product!.reviews!.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllReviewsScreen(
                                      reviews: product.reviews!,
                                      productName: product.title ?? 'Product',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        if (isLoading) ...[
                          Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ).redacted(context: context, redact: true),
                        ],
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isOutOfStock && !isLoading) 
          AddToCartButton(productId: product?.id ?? ''),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80.sp,
              color: Colors.red,
            ),
            SizedBox(height: 16.h),
            Text(
              'Error',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
