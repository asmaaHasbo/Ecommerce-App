# شرح: ليه `_startTimer()` يبدأ تلقائياً في الـ Constructor؟

## 🎯 السبب الرئيسي

عشان الـ OTP code له **صلاحية محددة (10 دقايق)** من لحظة إرساله، مش من لحظة ما المستخدم يضغط زرار!

## 📱 السيناريو الواقعي

### ❌ لو مبدأناش الـ Timer تلقائياً:

```
1. المستخدم يدخل email → API يبعت OTP
2. المستخدم يفتح شاشة OTP → Timer واقف (00:00)
3. المستخدم ياخد وقته يدور على الكود في الإيميل (5 دقايق)
4. يدخل الكود → يشتغل!
5. المشكلة: الكود فعلياً expired على السيرفر (بعد 10 دقايق من الإرسال)
   لكن الـ Timer عندنا بيقول لسه فيه وقت!
```

### ✅ لما نبدأ الـ Timer تلقائياً:

```
1. المستخدم يدخل email → API يبعت OTP (الساعة 2:00 PM)
2. المستخدم يفتح شاشة OTP → Timer يبدأ فوراً (10:00)
3. الـ Timer يعد تنازلي بالظبط زي السيرفر
4. لو المستخدم أخد 11 دقيقة → Timer يقول "expired" ✅
5. التطبيق والسيرفر متزامنين!
```

## 🔄 الـ Flow الكامل

```dart
// في app_router.dart
case Routes.otpScreen:
  final email = settings.arguments as String;
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (context) => VerifyOtpCubit(getIt()),  // ← هنا يتم إنشاء الـ Cubit
      child: OtpScreen(email: email),
    ),
  );

// في verify_otp_cubit.dart
VerifyOtpCubit(this._repo) : super(VerifyOtpInitial()) {
  _startTimer();  // ← يبدأ فوراً بمجرد إنشاء الـ Cubit
}
```

## ⏱️ Timeline مقارنة

### السيرفر:
```
2:00:00 PM → API يبعت OTP
2:10:00 PM → الكود يـ expire
```

### التطبيق (مع Timer تلقائي):
```
2:00:05 PM → المستخدم يفتح شاشة OTP
2:00:05 PM → Timer يبدأ (10:00)
2:10:05 PM → Timer يقول "expired"
```

✅ فرق بسيط (5 ثواني) مقبول

### التطبيق (بدون Timer تلقائي):
```
2:00:05 PM → المستخدم يفتح شاشة OTP
2:00:05 PM → Timer واقف (00:00)
2:05:00 PM → المستخدم يبدأ يكتب الكود
2:05:00 PM → Timer يبدأ (10:00)
2:15:00 PM → Timer يقول "expired"
```

❌ الكود فعلياً expired من 2:10:00 PM لكن الـ Timer بيقول لسه فيه وقت!

## 🎓 الخلاصة

الـ Timer يبدأ تلقائياً عشان:
1. **التزامن مع السيرفر**: الكود له صلاحية من لحظة الإرسال، مش من لحظة الاستخدام
2. **User Experience أفضل**: المستخدم يشوف الوقت الحقيقي المتبقي
3. **منع الـ confusion**: لو الكود expired على السيرفر لكن الـ Timer بيقول لسه فيه وقت، المستخدم هيتلخبط
4. **Security**: نمنع المستخدم من استخدام كود expired

## 🔄 متى يتم إعادة تشغيل الـ Timer؟

```dart
Future<void> resendCode(String email) async {
  await _repo.resendResetCode(email);  // السيرفر يبعت كود جديد
  _startTimer();                        // نبدأ Timer جديد (10 دقايق)
  // مسح الخانات القديمة
}
```

عند Resend، السيرفر بيبعت كود جديد بصلاحية جديدة (10 دقايق جديدة)
فلازم نعيد الـ Timer من جديد عشان يتزامن مع الكود الجديد.
