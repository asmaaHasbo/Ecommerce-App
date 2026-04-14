import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza_ecommerce_app/core/routing/app_router.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';

class LazaApp extends StatelessWidget {
  const LazaApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        initialRoute: Routes.splashScreen,
        // home: ProductDetailsScreen(),
        onGenerateRoute: appRouter.generateRoute,
        // home:,
      ),
    );
  }
}
