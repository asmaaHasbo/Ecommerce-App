import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/loading/redacted_helper.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_item_model.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/cart_item_widget.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final int totalPrice;
  final bool isLoading;

  const CartItemsList({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: isLoading ? 3 : cartItems.length,
            itemBuilder: (context, index) {
              return CartItemWidget(
                cartItemModel: isLoading ? null : cartItems[index],
              ).redactedHelper(
                context: context,
                isLoading: isLoading,
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: AppTextStyles.font14w500Black.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$$totalPrice',
                    style: AppTextStyles.font17w600Black.copyWith(
                      color: AppColors.mainColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        // Navigate to payment screen
                        Navigator.pushNamed(
                          context,
                          Routes.paymentScreen,
                          arguments: {
                            'amount': totalPrice.toDouble(),
                            'customerName': 'Customer Name', // TODO: Get from user profile
                            'customerEmail': 'customer@example.com', // TODO: Get from user profile
                            'customerPhone': '+201234567890', // TODO: Get from user profile
                            'orderReference': 'ORDER_${DateTime.now().millisecondsSinceEpoch}',
                          },
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: AppTextStyles.font17W600white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
