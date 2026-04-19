import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helpers/user_data_helper.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class WelcomeHeader extends StatefulWidget {
  const WelcomeHeader({super.key});

  @override
  State<WelcomeHeader> createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends State<WelcomeHeader> {
  String _username = 'User';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final username = await UserDataHelper.getUsername();
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $_username',
            style: AppTextStyles.font24w700Black,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 4.h),
          Text('Welcome to Laza Store.', style: AppTextStyles.font15W400lightGray),
        ],
      ),
    );
  }
}
