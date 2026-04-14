// ==================== Product Item Model ====================
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/add_to_cart_button.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/description_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/product_image_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/product_images_list.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/product_info_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/review_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/size_selection_section.dart';
import 'package:laza_ecommerce_app/features/product_details/ui/widget/total_price_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductItemModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedImageIndex = 0;
  String? selectedSize;

  final String reviewerName = 'Ronald Richards';
  final String reviewDate = '13 Sep, 2020';
  final double reviewRating = 4.8;
  final String reviewComment =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...';
  final String reviewAvatar = 'https://i.pravatar.cc/150?img=12';

  @override
  Widget build(BuildContext context) {
    log('from product detaiel product id ${widget.product.id}');
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageSection(
                    mainImage: widget.product.coverPictureUrl!,
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
                            category:
                                widget.product.categories?.first ?? 'null',
                            name: widget.product.name ?? 'no name',
                            price: '\$${widget.product.price}',
                          ),
                          SizedBox(height: 20.h),
                          ProductImagesList(
                            images: [
                              widget.product.coverPictureUrl!,
                              widget.product.coverPictureUrl!,
                              widget.product.coverPictureUrl!,
                            ],
                            selectedIndex: selectedImageIndex,
                            onImageSelected: (index) {
                              setState(() {
                                selectedImageIndex = index;
                              });
                            },
                          ),
                          SizedBox(height: 24.h),
                          SizeSelectionSection(
                            sizes: ['S', 'M', 'XL', 'XXL'],
                            selectedSize: selectedSize,
                            onSizeSelected: (size) {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                          ),
                          SizedBox(height: 24.h),
                          DescriptionSection(
                            description: widget.product.description!,
                          ),
                          SizedBox(height: 24.h),
                          ReviewSection(
                            reviewerName: reviewerName,
                            reviewDate: reviewDate,
                            reviewRating: reviewRating,
                            reviewComment: reviewComment,
                            reviewAvatar: reviewAvatar,
                          ),
                          SizedBox(height: 24.h),
                          TotalPriceSection(
                            totalPrice: '${widget.product.price}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AddToCartButton(productId: widget.product.id!),
        ],
      ),
    );
  }
}
