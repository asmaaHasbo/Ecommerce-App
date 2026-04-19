import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username') ?? 'User';
      _userEmail = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.3),
                  AppColors.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.person,
              size: 50.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            _userName ?? 'User',
            style: AppTextStyles.font20w600black,
          ),
          if (_userEmail != null && _userEmail!.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              _userEmail!,
              style: AppTextStyles.font14w400gray,
            ),
          ],
        ],
      ),
    );
  }
}
