import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/categories_bloc_builder.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/custom_app_bar.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/product_bloc_builder.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/search_bar_widget.dart';
import 'package:laza_ecommerce_app/features/home/ui/widgets/welcome_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // تحميل الـ products والـ categories
    context.read<HomeCubit>().getProducts();
    context.read<HomeCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeHeader(),
            SizedBox(height: 16.h),
            const SearchBarWidget(),
            SizedBox(height: 24.h),
            CategoriesBlocBuilder(),
            SizedBox(height: 24.h),
            ProductBlocBuilder(),
            // const ProductGrid(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
