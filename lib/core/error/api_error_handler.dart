// lib/core/network/api_error_handler.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'api_exceptions.dart';


/// ApiException  ل   DioException  تحويل ال 
class ApiErrorHandler {
  // منع إنشاء instance من الكلاس
  ApiErrorHandler._();

  // ══════════════════════════════════════════════════════════════

  static ApiException handle(dynamic error) {
    // لو الخطأ مش من Dio
    if (error is! DioException) {
      return UnexpectedException(error.toString());
    }

    // حلل نوع الـ DioException
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        //لو النت مش شغال
        if (error.error is SocketException) {
          return const NetworkException();
        }
        //لو السيرفر مش شغال
        return const NetworkException('Failed to connect to the server');

      case DioExceptionType.cancel:
        return const UnexpectedException('Request was cancelled');

      case DioExceptionType.badCertificate:
        return const UnexpectedException('Bad certificate');

      // خطأ من السيرفر (400, 401, 500...) هنا هيرحع رسالة الخطأ اللي جت من السيرفر زي مثلا ً "email غير صحيح"
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      default:
        return UnexpectedException(
          error.message ?? 'Unexpected error occurred',
        );
    }
  }

  //   دالة خاصة للتعامل مع server exceptionر
  static ApiException _handleBadResponse(Response? response) {
    // لو مفيش استجابة خالص
    if (response == null) {
      return const ServerException('No response from server');
    }

    final statusCode = response.statusCode ?? 0;
    // استخراج رسالة الخطأ من response
    String errorMessage = _extractErrorMessage(response.data);

    switch (statusCode) {
      case 400:
        return ServerException(
          //لو مفيش رسالة خطأ من السيرفر يرجع رسالة عامة
          errorMessage.isEmpty ? 'Invalid request data' : errorMessage,
          statusCode: 400,
        );

      case 401:
        return UnauthorizedException(
          errorMessage.isEmpty ? 'Unauthorized. Please login' : errorMessage,
        );

      // غير مصرح بالدخول
      case 403:
        return ServerException(
          errorMessage.isEmpty ? 'Access forbidden' : errorMessage,
          statusCode: 403,
        );

      case 404:
        return ServerException(
          errorMessage.isEmpty ? 'Resource not found' : errorMessage,
          statusCode: 404,
        );

      case 422:
        return ServerException(
          errorMessage.isEmpty ? 'Validation error' : errorMessage,
          statusCode: 422,
        );

      case 429:
        return ServerException(
          errorMessage.isEmpty
              ? 'Too many requests. Please try later'
              : errorMessage,
          statusCode: 429,
        );

      case 500:
        return ServerException(
          errorMessage.isEmpty ? 'Internal server error' : errorMessage,
          statusCode: 500,
        );

      case 502:
        return ServerException(
          errorMessage.isEmpty ? 'Bad gateway' : errorMessage,
          statusCode: 502,
        );

      case 503:
        return ServerException(
          errorMessage.isEmpty ? 'Service unavailable' : errorMessage,
          statusCode: 503,
        );

      // حالات أخرى
      default:
        return ServerException(
          errorMessage.isEmpty
              ? 'Error occurred (Code: $statusCode)'
              : errorMessage,
          statusCode: statusCode,
        );
    }
  }

  // دالة لاستخراج رسالة الخطأ من أي Response
  static String _extractErrorMessage(dynamic responseData) {
    // لو الـ Response مش Map، ارجع رسالة عامة
    if (responseData is! Map<String, dynamic>) {
      return 'Unexpected error occurred';
    }

    final data = responseData;

    // ══════════════════════════════════════════════════════
    // السيناريو 1: errors موجودة - نعرضها أولاً (الأهم)
    // ══════════════════════════════════════════════════════
    
    // السيناريو 1.1: errors كـ Object (Map)
    // {
    //   "message": "One or more errors occurred!",
    //   "errors": {
    //     "email": "البريد مطلوب",
    //     "password": ["كلمة المرور قصيرة", "يجب أن تحتوي على حرف كبير"]
    //   }
    // }
    if (data['errors'] != null && data['errors'] is Map) {
      final errors = data['errors'] as Map<String, dynamic>;

      // تحقق لو الـ errors فيه msg (express-validator format)
      // { "errors": { "msg": "must be at least 6 chars", "param": "password" } }
      if (errors.containsKey('msg') && errors['msg'] is String) {
        final msg = errors['msg'] as String;
        final param = errors['param'];
        
        // لو فيه param، ضيفه قبل الرسالة
        if (param != null && param is String && param.isNotEmpty) {
          return '$param: $msg';
        }
        
        return msg;
      }

      // جمع كل الأخطاء في List
      final errorMessages = <String>[];

      errors.forEach((key, value) {
        if (value is String) {
          errorMessages.add(value);
        } else if (value is List) {
          // أحياناً الخطأ الواحد يكون List
          // "password": ["كلمة المرور قصيرة", "يجب أن تحتوي على حرف كبير"]
          errorMessages.addAll(value.map((e) => e.toString()));
        }
      });

      // لو فيه أخطاء، ارجعهم كلهم
      if (errorMessages.isNotEmpty) {
        return errorMessages.join('\n'); // كل خطأ في سطر
      }
    }

    // السيناريو 1.2: errors كـ List
    // {
    //   "errors": [
    //     "البريد الإلكتروني مطلوب",
    //     "كلمة المرور قصيرة"
    //   ]
    // }
    // أو
    // {
    //   "errors": [
    //     { "msg": "must be at least 6 chars", "param": "password" }
    //   ]
    // }
    if (data['errors'] != null && data['errors'] is List) {
      final errors = data['errors'] as List;

      if (errors.isNotEmpty) {
        final errorMessages = <String>[];
        
        for (var error in errors) {
          if (error is String) {
            errorMessages.add(error);
          } else if (error is Map && error['msg'] != null) {
            // express-validator format in array
            final msg = error['msg'].toString();
            final param = error['param'];
            
            // لو فيه param، ضيفه قبل الرسالة
            if (param != null && param is String && param.isNotEmpty) {
              errorMessages.add('$param: $msg');
            } else {
              errorMessages.add(msg);
            }
          } else {
            errorMessages.add(error.toString());
          }
        }
        
        return errorMessages.join('\n');
      }
    }

    // ══════════════════════════════════════════════════════
    // السيناريو 2: رسالة واحدة بسيطة (لو مفيش errors)
    // ══════════════════════════════════════════════════════
    // { "message": "البريد الإلكتروني غير صحيح" }
    // { "error": "البريد الإلكتروني غير صحيح" }

    if (data['message'] != null && data['message'] is String) {
      final message = data['message'] as String;
      // لو الرسالة مش عامة، ارجعها
      if (message.isNotEmpty && message != 'One or more errors occurred!' && message != 'fail') {
        return message;
      }
    }

    if (data['error'] != null && data['error'] is String) {
      return data['error'] as String;
    }

    // ══════════════════════════════════════════════════════
    // لو مفيش أي حاجة من اللي فوق، ارجع رسالة عامة
    // ══════════════════════════════════════════════════════
    return 'Unexpected error occurred';
  }
}
