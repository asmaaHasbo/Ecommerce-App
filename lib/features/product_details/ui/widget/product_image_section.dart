import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laza_ecommerce_app/core/shared/shimmer/image_shimmer.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/screens/image_viewer_screen.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/back_button_widget.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/wishlist_button_widget.dart';

class ProductImageSection extends StatelessWidget {
  final String mainImage;
  final List<String> allImages;
  final int currentIndex;
  final String productId;

  const ProductImageSection({
    super.key,
    required this.mainImage,
    required this.allImages,
    required this.currentIndex,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (allImages.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageViewerScreen(
                images: allImages,
                initialIndex: currentIndex,
              ),
            ),
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 400.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: mainImage,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  ImageShimmer(height: 400.h, width: double.infinity),
              errorWidget: (context, url, error) => Container(
                color: const Color(0xFFF5F5F5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      size: 80.sp,
                      color: const Color(0xFFBDBDBD),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Image not available',
                      style: TextStyle(
                        color: const Color(0xFF8E8E93),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                ),
              ),
            ),
            Positioned(top: 50.h, left: 20.w, child: const BackButtonWidget()),
            Positioned(
              top: 50.h,
              right: 20.w,
              child: WishlistButtonWidget(productId: productId),
            ),
            if (allImages.length > 1)
              Positioned(
                bottom: 20.h,
                right: 20.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.zoom_in, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'Tap to zoom',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
