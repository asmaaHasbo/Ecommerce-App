import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/helper/constant.dart';
import 'package:laza_ecommerce_app/core/helper/shared_preferences.dart';
import 'package:laza_ecommerce_app/core/networking/token_storage.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // انتظر 2 ثانية للـ splash
    await Future.delayed(const Duration(seconds: 2));

    // تحقق من حالة المستخدم
    final hasSeenOnboarding = await SharedPrefHelper.getBool(SharedPrefKeys.hasSeenOnboarding);
    final hasToken = await TokenStorage.hasToken();

    String nextRoute;

    if (!hasSeenOnboarding) {
      // أول مرة يفتح التطبيق
      nextRoute = Routes.onboardingScreen;
    } else if (!hasToken) {
      // شاف الـ onboarding بس مش مسجل دخول
      nextRoute = Routes.getStartedScreen;
    } else {
      // مسجل دخول
      nextRoute = Routes.mainScreen;
    }

    if (!mounted) return;
    
    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // حط الـ logo هنا
            Icon(
              Icons.shopping_bag,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            const Text(
              'LAZA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
