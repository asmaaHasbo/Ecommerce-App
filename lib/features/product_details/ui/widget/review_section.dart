import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/review_model.dart';

class ReviewSection extends StatelessWidget {
  final List<ReviewModel>? reviews;
  final VoidCallback? onViewAllTap;

  const ReviewSection({
    super.key,
    this.reviews,
    this.onViewAllTap,
  });

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${date.day} ${months[date.month - 1]}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (reviews == null || reviews!.isEmpty) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reviews', style: AppTextStyles.font16w600black),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'No reviews yet',
            style: AppTextStyles.font14w400gray,
          ),
        ],
      );
    }

    final firstReview = reviews!.first;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: AppTextStyles.font16w600black),
            if (reviews!.length > 1)
              GestureDetector(
                onTap: () => onViewAllTap?.call(),
                child: Text(
                  'View All (${reviews!.length})',
                  style: AppTextStyles.font14w400gray.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: const Color(0xFF2B2B2B),
              child: Text(
                firstReview.user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                style: AppTextStyles.font16w600black.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          firstReview.user?.name ?? 'Anonymous',
                          style: AppTextStyles.font14w500maincolor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${firstReview.rating ?? 0}',
                            style: AppTextStyles.font14w500maincolor,
                          ),
                          SizedBox(width: 4.w),
                          Text('rating', style: AppTextStyles.font12w400gray),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14.sp,
                            color: const Color(0xFF8E8E93),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _formatDate(firstReview.createdAt),
                            style: AppTextStyles.font12w400gray,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < (firstReview.rating ?? 0)
                                ? Icons.star
                                : Icons.star_border,
                            size: 16.sp,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    firstReview.review ?? 'No comment',
                    style: AppTextStyles.font14w400gray,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
