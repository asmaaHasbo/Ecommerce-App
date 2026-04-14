// lib/core/network/api_exceptions.dart

// الكلاس الأساسي لجميع أخطاء الـ API
abstract class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  // عشان لما تطبع الـ Exception يطلع الرسالة مباشرة
  @override
  String toString() => message;
}

// ══════════════════════════════════════════════════════════════

// خطأ في الاتصال بالإنترنت
class NetworkException extends ApiException {
  const NetworkException([String? message])
    : super(message ?? 'No internet connection');
}

// خطأ من السيرفر (400, 401, 500...) هنا هيرحع رسالة الخطأ اللي جت من السيرفر زي مثلا ً "email غير صحيح"
class ServerException extends ApiException {
  final int? statusCode;

  const ServerException(super.message, {this.statusCode});
}

// انتهاء وقت الاتصال
class TimeoutException extends ApiException {
  const TimeoutException([String? message])
    : super(message ?? 'Connection timeout. Please try again');
}

// غير مصرح بالدخول (401)
class UnauthorizedException extends ApiException {
  const UnauthorizedException([String? message])
    : super(message ?? 'Unauthorized. Please login');
}

// خطأ غير متوقع
class UnexpectedException extends ApiException {
  const UnexpectedException([String? message])
    : super(message ?? 'Unexpected error occurred');
}

// خطأ في معالجة البيانات (Parsing)
class ParsingException extends ApiException {
  const ParsingException([String? message])
    : super(message ?? 'Error processing data');
}
