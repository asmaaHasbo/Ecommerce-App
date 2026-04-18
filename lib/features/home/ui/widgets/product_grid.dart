import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/di/dependency_injection.dart';
import 'package:laza_ecommerce_app/core/shared/loading/redacted_helper.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/product_card.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/product_details_screen.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.scrollController,
    required this.hasMore,
    this.isLoading = false,
  });

  final List<ProductItemModel> products;
  final ScrollController scrollController;
  final bool hasMore;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? 6 : products.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          GridView.builder(
            controller: scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.7,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (isLoading) {
                return ProductCard(product: null).redactedHelper(
                  context: context,
                  isLoading: true,
                );
              }

              log('form grid ui product length :${products.length}');
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CartCubit(getIt()),
                        child: ProductDetailsScreen(product: products[index]),
                      ),
                    ),
                  );
                },
                child: ProductCard(product: products[index]),
              );
            },
          ),
          if (hasMore && !isLoading) ...[
            SizedBox(height: 16.h),
            Center(
              child: CircularProgressIndicator(),
            ),
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}
