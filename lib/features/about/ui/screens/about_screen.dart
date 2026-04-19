import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/about/ui/widgets/about_app_info.dart';
import 'package:laza_ecommerce_app/features/about/ui/widgets/about_header.dart';
import 'package:laza_ecommerce_app/features/about/ui/widgets/about_profile_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkBlack),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.mainScreen);
          },
        ),
        title: Text(
          'About',
          style: AppTextStyles.font17w600Black,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AboutHeader(),
            SizedBox(height: 24),
            AboutProfileCard(),
            SizedBox(height: 24),
            AboutAppInfo(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
