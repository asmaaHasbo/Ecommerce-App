import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/onboarding/widgets/onboarding_container.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              // الصورة الرئيسية
              Positioned.fill(
                child: Image.asset(
                  'assets/images/onboarding_boy_chair_img.png',
                  fit: BoxFit.cover,
                ),
              ),

              // الـ Container الأبيض تحت
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: OnboardingContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
