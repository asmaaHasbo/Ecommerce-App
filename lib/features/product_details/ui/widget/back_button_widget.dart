import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 44.w,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
    );
  }
}
