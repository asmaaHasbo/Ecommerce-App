import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/di/dependency_injection.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:laza_ecommerce_app/features/profile/ui/widgets/profile_header.dart';
import 'package:laza_ecommerce_app/features/profile/ui/widgets/profile_info_section.dart';
import 'package:laza_ecommerce_app/features/profile/ui/widgets/profile_logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
            style: AppTextStyles.font17w600Black,
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(),
              SizedBox(height: 24),
              ProfileInfoSection(),
              SizedBox(height: 32),
              ProfileLogoutButton(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
