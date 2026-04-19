import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/review_model.dart';

class AllReviewsScreen extends StatelessWidget {
  final List<ReviewModel> reviews;
  final String productName;

  const AllReviewsScreen({
    super.key,
    required this.reviews,
    required this.productName,
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
        'Dec',
      ];
      return '${date.day} ${months[date.month - 1]}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Reviews', style: AppTextStyles.font20w700black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              border: Border(
                bottom: BorderSide(color: const Color(0xFFE0E0E0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: AppTextStyles.font16w600black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Text(
                  '${reviews.length} ${reviews.length == 1 ? 'Review' : 'Reviews'}',
                  style: AppTextStyles.font14w400gray,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: reviews.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 32.h, color: const Color(0xFFE0E0E0)),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _ReviewItem(review: review, formatDate: _formatDate);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final ReviewModel review;
  final String Function(String?) formatDate;

  const _ReviewItem({required this.review, required this.formatDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: const Color(0xFF2B2B2B),
          child: Text(
            review.user?.name?.substring(0, 1).toUpperCase() ?? 'U',
            style: AppTextStyles.font16w600black.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
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
                      review.user?.name ?? 'Anonymous',
                      style: AppTextStyles.font16w600black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 14.sp, color: Colors.amber),
                        SizedBox(width: 4.w),
                        Text(
                          '${review.rating ?? 0}',
                          style: AppTextStyles.font14w500maincolor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
                    color: const Color(0xFF8E8E93),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    formatDate(review.createdAt),
                    style: AppTextStyles.font12w400gray,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < (review.rating ?? 0)
                        ? Icons.star
                        : Icons.star_border,
                    size: 16.sp,
                    color: Colors.amber,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                review.review ?? 'No comment',
                style: AppTextStyles.font14w400gray,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
