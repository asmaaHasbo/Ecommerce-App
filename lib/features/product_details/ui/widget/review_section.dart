import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class ReviewSection extends StatelessWidget {
  final String reviewerName;
  final String reviewDate;
  final double reviewRating;
  final String reviewComment;
  final String reviewAvatar;

  const ReviewSection({
    super.key,
    required this.reviewerName,
    required this.reviewDate,
    required this.reviewRating,
    required this.reviewComment,
    required this.reviewAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: AppTextStyles.font16w600black),
            Text('View All', style: AppTextStyles.font14w400gray),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: NetworkImage(reviewAvatar),
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
                          reviewerName,
                          style: AppTextStyles.font14w500maincolor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$reviewRating',
                            style: AppTextStyles.font14w500maincolor,
                          ),
                          SizedBox(width: 4.w),
                          Text('rating', style: AppTextStyles.font12w400gray),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // FIXED: استخدام Column بدلاً من Row لتجنب Overflow
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
                          Text(reviewDate, style: AppTextStyles.font12w400gray),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          ...List.generate(
                            4,
                            (index) => Icon(
                              Icons.star,
                              size: 16.sp,
                              color: Colors.amber,
                            ),
                          ),
                          Icon(
                            Icons.star_border,
                            size: 16.sp,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(reviewComment, style: AppTextStyles.font14w400gray),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
