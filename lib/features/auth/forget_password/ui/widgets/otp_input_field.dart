import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';

/// Widget للخانة الواحدة من الـ OTP (من 6 خانات)
/// كل خانة تقبل رقم واحد فقط وتنتقل تلقائياً للخانة التالية
class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;      // الخانة اللي بعدها (nullable لأن آخر خانة مفيش بعدها حاجة)
  final FocusNode? previousFocusNode;  // الخانة اللي قبلها (nullable لأن أول خانة مفيش قبلها حاجة)

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 60.h,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,  // لوحة مفاتيح أرقام فقط
        maxLength: 1,                         // رقم واحد فقط في كل خانة
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly  // يسمح بالأرقام فقط (0-9)
        ],
        decoration: InputDecoration(
          counterText: '',  // إخفاء عداد الأحرف (1/1)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.lightGray, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
        
        // ============ التنقل التلقائي بين الخانات ============
        /// يتم استدعاء onChanged كل ما المستخدم يكتب أو يمسح حرف
        onChanged: (value) {
          // ============ حالة 1: المستخدم كتب رقم ============
          if (value.isNotEmpty && nextFocusNode != null) {
            // لو الخانة بقت فيها رقم وفيه خانة بعدها
            // انتقل تلقائياً للخانة التالية
            // مثال: المستخدم كتب "5" في الخانة الأولى → ينتقل للخانة الثانية
            nextFocusNode!.requestFocus();
          } 
          // ============ حالة 2: المستخدم مسح الرقم (Backspace) ============
          else if (value.isEmpty && previousFocusNode != null) {
            // لو الخانة بقت فاضية وفيه خانة قبلها
            // ارجع للخانة السابقة
            // مثال: المستخدم مسح الرقم من الخانة الثالثة → يرجع للخانة الثانية
            previousFocusNode!.requestFocus();
          }
          
          // ملاحظات:
          // - أول خانة: previousFocusNode = null (مفيش قبلها حاجة)
          // - آخر خانة: nextFocusNode = null (مفيش بعدها حاجة)
          // - الـ null check (&&) يمنع الـ crash لو حاولنا نوصل لخانة مش موجودة
        },
      ),
    );
  }
}
