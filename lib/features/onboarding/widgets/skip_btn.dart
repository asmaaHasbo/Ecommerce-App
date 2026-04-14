import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/helper/constant.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/helper/shared_preferences.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class SkipBtn extends StatelessWidget {
  const SkipBtn({super.key});

  Future<void> _handleSkip(BuildContext context) async {
    // حفظ إن المستخدم شاف الـ onboarding
    await SharedPrefHelper.setData(SharedPrefKeys.hasSeenOnboarding, true);
    
    if (context.mounted) {
      context.pushReplacementNamed(Routes.getStartedScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleSkip(context),
      child: Text(
        'Skip',
        style: AppTextStyles.font17W500lightGray,
        textAlign: TextAlign.center,
      ),
    );
  }
}
