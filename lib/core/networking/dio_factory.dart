import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/networking/token_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio? _dio;
  DioFactory._();

  static Dio getDio() {
    if (_dio != null) {
      return _dio!;
    }

    _dio = Dio();

    _dio!.options = _createBaseOptions();

    // أضف الـ Interceptors
    _addInterceptors(_dio!);

    return _dio!;
  }

  static BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 30),

      receiveTimeout: const Duration(seconds: 30),

      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',

        'Accept': 'application/json',

        'Accept-Language': 'en',

        /// Headers إضافية مفيدة (اختياري)

        // 'App-Version': '1.0.0',  // نسخة التطبيق
        // 'Platform': 'mobile',     // نوع المنصة (mobile/web)
        // 'Device-Type': 'android', // نوع الجهاز
      },

      responseType: ResponseType.json,

      // فقط 2xx و 3xx يعتبروا success، أي حاجة تانية exception
      validateStatus: (status) {
        return status != null && status >= 200 && status < 300;
      },

      followRedirects: true,

      maxRedirects: 5,

      receiveDataWhenStatusError: true,
    );
  }

  static void _addInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();

          /// لو Token موجود، أضفه للـ headers
          if (token != null && token.isNotEmpty) {
            options.headers['token'] = token;
          }

          handler.next(options);
        },

        onResponse: (response, handler) {
          log(
            '✅ print  RESPONSE from dio class [${response.statusCode}] => ${response.requestOptions.path}',
          );
          log('print Data from dio class: ${response.data}');
          handler.next(response);
        },

        onError: (error, handler) async {
          log(
            '❌print ERROR from dio class [${error.response?.statusCode}] => ${error.requestOptions.path}',
          );
          log('print ERROR Msg from dio class Message: ${error.message}');

          handler.next(error);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        /// requestHeader: طباعة headers الـ request
        // requestHeader: true,

        /// requestBody: طباعة body الـ request
        requestBody: true,

        /// responseHeader: طباعة headers الـ response
        // responseHeader: true,

        /// responseBody: طباعة body الـ response
        responseBody: true,

        /// error: طباعة الأخطاء
        error: true,

        /// compact: لو true، الطباعة تكون مختصرة
        compact: true,

        /// maxWidth: عرض الطباعة في الـ Console
        maxWidth: 90,
      ),
    );
  }

  /// محاولة تجديد Token من السيرفر
  ///
  /// آلية العمل:
  /// 1. نبعت refresh_token للسيرفر
  /// 2. السيرفر يرجع access_token جديد
  /// 3. نحفظ Token الجديد
  ///
  /// Returns: Token جديد أو null لو فشل
  // static Future<String?> _refreshToken(Dio dio) async {
  //   try {
  //     // استرجاع Refresh Token من Storage
  //     final refreshToken = await TokenStorage.getRefreshToken();

  //     if (refreshToken == null) {
  //       return null;
  //     }

  //     // إنشاء Dio جديد خاص بالتجديد
  //     // عشان ما ندخلش في infinite loop
  //     final refreshDio = Dio();
  //     refreshDio.options.baseUrl = dio.options.baseUrl;

  //     // إرسال request لتجديد Token
  //     final response = await refreshDio.post(
  //       'auth/refresh',
  //       data: {
  //         'refresh_token': refreshToken,
  //       },
  //     );

  //     // استخراج Token الجديد
  //     if (response.statusCode == 200 && response.data != null) {
  //       final newToken = response.data['data']['access_token'] as String?;
  //       final newRefreshToken = response.data['data']['refresh_token'] as String?;

  //       // حفظ Refresh Token الجديد (لو موجود)
  //       if (newRefreshToken != null) {
  //         await TokenStorage.saveRefreshToken(newRefreshToken);
  //       }

  //       return newToken;
  //     }

  //     return null;

  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('❌ Failed to refresh token: $e');
  //     }
  //     return null;
  //   }
  // }

  // // ────────────────────────────────────────────────────────
  // // معالجة Unauthorized
  // // ────────────────────────────────────────────────────────

  // /// معالجة حالة Unauthorized (Token منتهي ومش قادرين نجدده)
  // ///
  // /// الإجراءات:
  // /// 1. حذف كل البيانات المحفوظة
  // /// 2. تسجيل خروج المستخدم
  // /// 3. الانتقال لصفحة تسجيل الدخول
  // static Future<void> _handleUnauthorized() async {
  //   // حذف Token
  //   await TokenStorage.clearTokens();

  //   // هنا تقدر تضيف logic إضافي:
  //   // - تسجيل خروج من الـ Cubit
  //   // - الانتقال لصفحة Login
  //   // - عرض رسالة للمستخدم

  //   if (kDebugMode) {
  //     print('⚠️ User unauthorized - clearing session');
  //   }
  // }
}
