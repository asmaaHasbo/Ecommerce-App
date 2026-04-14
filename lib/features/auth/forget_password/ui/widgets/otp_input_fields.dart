import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/verify_otp_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/otp_input_field.dart';

/// Widget يعرض الـ 6 خانات للـ OTP في صف واحد
class OtpInputFields extends StatelessWidget {
  const OtpInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyOtpCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6, // عدد الخانات
        (index) => OtpInputField(
          controller: cubit.otpControllers[index],
          focusNode: cubit.otpFocusNodes[index],
          
          // ============ nextFocusNode: الخانة اللي بعدها ============
          /// 
          /// index < 5 ? cubit.otpFocusNodes[index + 1] : null
          /// 
          /// الشرح بالأمثلة:
          /// 
          /// index = 0 (الخانة الأولى):
          ///   0 < 5 ✅ true
          ///   nextFocusNode = cubit.otpFocusNodes[0 + 1] = otpFocusNodes[1]
          ///   → الخانة التالية هي الخانة رقم 1 ✅
          /// 
          /// index = 2 (الخانة الثالثة):
          ///   2 < 5 ✅ true
          ///   nextFocusNode = cubit.otpFocusNodes[2 + 1] = otpFocusNodes[3]
          ///   → الخانة التالية هي الخانة رقم 3 ✅
          /// 
          /// index = 5 (الخانة الأخيرة):
          ///   5 < 5 ❌ false
          ///   nextFocusNode = null
          ///   → مفيش خانة بعدها! ✅
          /// 
          /// ليه index < 5 مش index < 6؟
          /// لأن الـ index يبدأ من 0:
          /// [0, 1, 2, 3, 4, 5] ← 6 خانات
          /// آخر index = 5
          /// لو index = 5 → مفيش index + 1 (هيكون 6 وده out of bounds!)
          nextFocusNode: index < 5 ? cubit.otpFocusNodes[index + 1] : null,
          
          previousFocusNode: index > 0 ? cubit.otpFocusNodes[index - 1] : null,
        ),
      ),
    );
  }
}
