import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/networking/token_storage.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class LogoutHelper {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            'Logout',
            style: AppTextStyles.font17w600Black,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyles.font14w500Black,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.font15w500Purple,
              ),
            ),
            TextButton(
              onPressed: () async {
                await TokenStorage.clearAll();
                if (context.mounted) {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.getStartedScreen,
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
