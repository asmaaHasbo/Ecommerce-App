import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

class WishlistErrorWidget extends StatelessWidget {
  final String errorMessage;

  const WishlistErrorWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isAuthError = _isAuthenticationError(errorMessage);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(isAuthError),
          SizedBox(height: 16.h),
          _buildErrorTitle(isAuthError),
          SizedBox(height: 8.h),
          _buildErrorMessage(),
          SizedBox(height: 24.h),
          _buildActionButton(context, isAuthError),
        ],
      ),
    );
  }

  bool _isAuthenticationError(String message) {
    return message.toLowerCase().contains('login') ||
        message.toLowerCase().contains('logged in') ||
        message.toLowerCase().contains('unauthorized');
  }

  Widget _buildErrorIcon(bool isAuthError) {
    return Icon(
      isAuthError ? Icons.lock_outline_rounded : Icons.error_outline_rounded,
      size: 80.sp,
      color: isAuthError ? AppColors.mainColor : AppColors.orange,
    );
  }

  Widget _buildErrorTitle(bool isAuthError) {
    return Text(
      isAuthError ? 'Login Required' : 'Oops! Something went wrong',
      style: AppTextStyles.font17w600Black,
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Text(
        errorMessage,
        style: AppTextStyles.font14w400gray,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, bool isAuthError) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(context, isAuthError),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        isAuthError ? 'Login Now' : 'Try Again',
        style: AppTextStyles.font17W600white,
      ),
    );
  }

  void _handleButtonPress(BuildContext context, bool isAuthError) {
    if (isAuthError) {
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
    } else {
      context.read<WishlistCubit>().getWishlist();
    }
  }
}
