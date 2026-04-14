import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/di/dependency_injection.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/verify_otp_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/forget_password_screen.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/new_password_screen.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/otp_screen.dart';
import 'package:laza_ecommerce_app/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/login/ui/login_screen.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/ui/sign_up_screen.dart';
import 'package:laza_ecommerce_app/features/get_started/get_started_screen.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/home/ui/main_screen.dart';
import 'package:laza_ecommerce_app/features/onboarding/onboarding_screen.dart';
import 'package:laza_ecommerce_app/features/splash/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.getStartedScreen:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpCubit(getIt()),
            child: SignUpScreen(),
          ),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(getIt()),
            child: LoginScreen(),
          ),
        );

      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = HomeCubit(getIt());
              cubit.emitGetCategories(); // استدعاء emitGetCategories
              cubit.emitGetProducts(); // استدعاء emitGetProducts
              return cubit;
            },
            child: MainScreen(),
          ),
        );

      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgetPasswordCubit(getIt()),
            child: const ForgetPasswordScreen(),
          ),
        );

      case Routes.otpScreen:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => VerifyOtpCubit(getIt()),
            child: OtpScreen(email: email),
          ),
        );

      case Routes.newPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const NewPasswordScreen(),
        );

      // case Routes.productDetailsScreen:
      // return MaterialPageRoute(builder: (_) => ProductDetailsScreen());

      default:
        // Unknown route
        return null;
    }
  }
}
