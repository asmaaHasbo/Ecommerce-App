import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/verify_reset_code_response_model.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/repositories/verify_reset_code_repo.dart';

part 'verify_otp_state.dart';

/// Cubit مسؤول عن إدارة شاشة التحقق من OTP
/// المسؤوليات:
/// 1. إدارة الـ 6 خانات للـ OTP (controllers + focus nodes)
/// 2. إدارة الـ Timer (10 دقايق countdown)
/// 3. إرسال الكود للـ API للتحقق منه
/// 4. إعادة إرسال الكود (Resend)
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyResetCodeRepo _repo;

  VerifyOtpCubit(this._repo) : super(VerifyOtpInitial()) {
    // بمجرد إنشاء الـ Cubit، نبدأ الـ Timer تلقائياً
    _startTimer();
  }

  // ============ إدارة الـ OTP Input Fields ============
  
  /// 6 Controllers للـ 6 خانات OTP
  /// كل controller مسؤول عن خانة واحدة
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  /// 6 Focus Nodes للتنقل بين الخانات
  /// لما المستخدم يكتب رقم، ينتقل تلقائياً للخانة التالية
  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  // ============ إدارة الـ Timer ============
  
  /// Timer object للـ countdown
  Timer? _timer;
  
  /// الوقت المتبقي بالثواني (600 ثانية = 10 دقايق)
  int _remainingSeconds = 600; // 10 minutes

  /// Getter للوصول للوقت المتبقي من خارج الـ Cubit
  int get remainingSeconds => _remainingSeconds;

  /// بدء الـ Timer من جديد
  /// يتم استدعاؤها عند:
  /// 1. إنشاء الـ Cubit (في الـ constructor)
  /// 2. عند إعادة إرسال الكود (Resend)
  void _startTimer() {
    // إلغاء أي timer قديم لو موجود
    _timer?.cancel();
    
    // إعادة تعيين الوقت لـ 10 دقايق
    _remainingSeconds = 600;
    
    // إرسال state للـ UI عشان يعرض الوقت المتبقي
    emit(VerifyOtpTimerUpdate(_remainingSeconds));

    // بدء timer جديد يعمل كل ثانية
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        // لو لسه فيه وقت، نقلل ثانية ونبعت state جديد
        _remainingSeconds--;
        emit(VerifyOtpTimerUpdate(_remainingSeconds));
      } else {
        // لو الوقت خلص، نوقف الـ timer ونبعت state إن الكود expired
        timer.cancel();
        emit(VerifyOtpExpired());
      }
    });
  }

  /// تحويل الثواني لصيغة MM:SS للعرض في الـ UI
  /// مثال: 125 ثانية → "02:05"
  String getFormattedTime() {
    final minutes = _remainingSeconds ~/ 60; // القسمة الصحيحة للحصول على الدقائق
    final seconds = _remainingSeconds % 60;  // الباقي هو الثواني
    
    // padLeft(2, '0') عشان نضيف صفر قدام الرقم لو أقل من 10
    // مثال: 5 → "05"
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // ============ الحصول على الكود المدخل ============
  
  /// جمع الأرقام من الـ 6 خانات في string واحد
  /// مثال: ["5", "3", "5", "8", "6", "3"] → "535863"
  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  /// التحقق إن المستخدم ملأ كل الخانات
  /// بنستخدمها قبل إرسال الكود للـ API
  bool isOtpComplete() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  // ============ التحقق من الكود (Verify) ============
  
  /// إرسال الكود للـ API للتحقق منه
  /// الخطوات:
  /// 1. التحقق إن كل الخانات ممتلئة
  /// 2. جمع الأرقام في string واحد
  /// 3. إرسال الكود للـ API
  /// 4. التحقق من الـ response (success أو fail)
  Future<void> verifyOtp() async {
    // لو الكود مش كامل، نعرض رسالة خطأ
    if (!isOtpComplete()) {
      emit(VerifyOtpFailure('Please enter complete OTP code'));
      return;
    }

    // عرض loading
    emit(VerifyOtpLoading());

    try {
      // جمع الأرقام من الـ 6 خانات
      final otpCode = getOtpCode();
      
      // إرسال الكود للـ API
      final response = await _repo.verifyResetCode(otpCode);
      
      // التحقق من الـ response
      // الـ API بيرجع "status": "Success" في حالة النجاح
      // أو "statusMsg": "fail" في حالة الفشل
      if (response.isSuccess) {
        // نجاح: الكود صحيح، ننتقل لشاشة New Password
        emit(VerifyOtpSuccess(response));
      } else {
        // فشل: الكود غلط أو expired
        emit(VerifyOtpFailure(response.message ?? 'Verification failed'));
      }
    } catch (e) {
      // لو حصل error في الـ API call
      emit(VerifyOtpFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ============ إعادة إرسال الكود (Resend) ============
  
  /// هل يمكن إعادة إرسال الكود؟
  /// فقط لما الوقت يخلص (0 ثانية)
  bool canResend() => _remainingSeconds == 0;

  /// إعادة إرسال الكود للـ email
  /// الخطوات:
  /// 1. التحقق إن الوقت خلص (canResend)
  /// 2. استدعاء API لإرسال كود جديد
  /// 3. إعادة تشغيل الـ Timer
  /// 4. مسح الخانات القديمة
  Future<void> resendCode(String email) async {
    // لو الوقت لسه مخلصش، متعملش حاجة
    if (!canResend()) return;

    // عرض loading
    emit(VerifyOtpLoading());

    try {
      // استدعاء API لإرسال كود جديد (نفس API الـ Forget Password)
      await _repo.resendResetCode(email);
      
      // إعادة تشغيل الـ Timer من جديد (10 دقايق)
      _startTimer();
      
      // مسح كل الخانات عشان المستخدم يدخل الكود الجديد
      for (var controller in otpControllers) {
        controller.clear();
      }
      
      // إرسال state إن الكود اتبعت بنجاح
      emit(VerifyOtpResent());
    } catch (e) {
      // لو حصل error، نعرض رسالة الخطأ
      // نشيل كلمة "Exception: " من أول الرسالة عشان تكون أنظف
      emit(VerifyOtpFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ============ تنظيف الموارد (Cleanup) ============
  
  /// عند إغلاق الـ Cubit (مثلاً لما نخرج من الشاشة)
  /// لازم ننضف الموارد عشان منعملش memory leak
  @override
  Future<void> close() {
    // إيقاف الـ Timer
    _timer?.cancel();
    
    // dispose لكل الـ controllers
    for (var controller in otpControllers) {
      controller.dispose();
    }
    
    // dispose لكل الـ focus nodes
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    
    return super.close();
  }
}
