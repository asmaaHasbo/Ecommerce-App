import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class ProductInfoSection extends StatelessWidget {
  final String category;
  final String name;
  final String price;

  const ProductInfoSection({
    super.key,
    required this.category,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category, style: AppTextStyles.font12w400gray),
              SizedBox(height: 8.h),
              Text(name, style: AppTextStyles.font20w700black),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Price', style: AppTextStyles.font12w400gray),
            SizedBox(height: 8.h),
            Text(price, style: AppTextStyles.font24w700black),
          ],
        ),
      ],
    );
  }
}

// class ProductInfoSection extends StatelessWidget {
// final ProductItemModel product ;

//   const ProductInfoSection({
//     super.key, required this.product,

//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 product.categories?.first ?? 'dd',
//                 style: AppTextStyles.font12w400gray,
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 product.name ?? 'no name',
//                 style: AppTextStyles.font20w700black,
//               ),
//             ],
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               'Price',
//               style: AppTextStyles.font12w400gray,
//             ),
//             SizedBox(height: 8.h),
//             Text(
//            '${product.price }',
//               style: AppTextStyles.font24w700black,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
