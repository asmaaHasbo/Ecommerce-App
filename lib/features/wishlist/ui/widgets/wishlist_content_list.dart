import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/loading/redacted_helper.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:laza_ecommerce_app/features/wishlist/ui/widgets/empty_wishlist_widget.dart';
import 'package:laza_ecommerce_app/features/wishlist/ui/widgets/wishlist_item_card.dart';

class WishlistContentList extends StatelessWidget {
  const WishlistContentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final wishlistCubit = context.read<WishlistCubit>();
        final isLoading = state is WishlistLoading;

        if (!isLoading && wishlistCubit.wishlistProducts.isEmpty) {
          return const EmptyWishlistWidget();
        }

        // Show 5 placeholder items during loading
        final itemsToShow = isLoading
            ? List.generate(5, (index) => _getDummyProduct())
            : wishlistCubit.wishlistProducts;

        return RefreshIndicator(
          onRefresh: () => wishlistCubit.getWishlist(),
          color: AppColors.mainColor,
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: itemsToShow.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return WishlistItemCard(
                product: itemsToShow[index],
              ).redactedHelper(
                context: context,
                isLoading: isLoading,
              );
            },
          ),
        );
      },
    );
  }

  // Dummy product for loading state
  ProductItemModel _getDummyProduct() {
    return ProductItemModel(
      title: 'Loading Product Name Here',
      price: 99,
      imageCover: '',
    );
  }
}
