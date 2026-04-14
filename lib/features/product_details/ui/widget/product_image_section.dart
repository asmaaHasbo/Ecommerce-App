import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart'; // استيراد المكتبة
import 'package:laza_ecommerce_app/features/product_details/ui/widget/back_button_widget.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/cart_button_widget.dart';

class ProductImageSection extends StatelessWidget {
  final String mainImage;

  const ProductImageSection({super.key, required this.mainImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      child: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: mainImage,
              height: 350.h,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(top: 50.h, left: 20.w, child: const BackButtonWidget()),
          Positioned(top: 50.h, right: 20.w, child: const CartButtonWidget()),
        ],
      ),
    );
  }
}
