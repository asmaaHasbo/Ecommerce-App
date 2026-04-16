import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza_ecommerce_app/core/networking/token_storage.dart';
import 'package:laza_ecommerce_app/core/routing/app_router.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';

class LazaApp extends StatefulWidget {
  const LazaApp({super.key});

  @override
  State<LazaApp> createState() => _LazaAppState();
}

class _LazaAppState extends State<LazaApp> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    _determineInitialRoute();
  }

  Future<void> _determineInitialRoute() async {
    // تحديد الصفحة الأولى بناءً على حالة تسجيل الدخول فقط
    final hasToken = await TokenStorage.hasToken();

    String nextRoute;

    if (hasToken) {
      // مسجل دخول → روح للـ Home
      nextRoute = Routes.mainScreen;
    } else {
      // مش مسجل دخول → روح للـ GetStarted
      nextRoute = Routes.getStartedScreen;
    }

    setState(() {
      _initialRoute = nextRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    // انتظر تحديد الـ route الأول
    if (_initialRoute == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    final AppRouter appRouter = AppRouter();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Laza ecommerce App',
        theme: ThemeData(
          textTheme: GoogleFonts.cairoTextTheme(),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: _initialRoute,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
