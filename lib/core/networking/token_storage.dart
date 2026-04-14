// lib/core/storage/token_storage.dart

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// 
class TokenStorage {
  
  // ══════════════════════════════════════════════════════════════
  // Keys - مفاتيح الحفظ في SharedPreferences
  // ══════════════════════════════════════════════════════════════
  
  /// مفتاح Access Token
  /// Access Token = الـ Token اللي بيستخدم في كل request
  /// عمره قصير (مثلاً 15 دقيقة أو ساعة)
  static const String _accessTokenKey = 'access_token';
  
  /// مفتاح Refresh Token
  /// Refresh Token = الـ Token اللي بيستخدم لتجديد Access Token
  /// عمره طويل (مثلاً أسبوع أو شهر)
  static const String _refreshTokenKey = 'refresh_token';
  
  // ══════════════════════════════════════════════════════════════
  // منع إنشاء instance
  // ══════════════════════════════════════════════════════════════
  
  TokenStorage._();
  
  // ══════════════════════════════════════════════════════════════
  // حفظ Tokens
  // ══════════════════════════════════════════════════════════════
  
  /// حفظ Access Token
  /// 
  /// [token] - الـ Token المراد حفظه
  /// 
  /// متى نستخدمها؟
  /// - بعد Login ناجح
  /// - بعد تجديد Token
  /// 
  /// مثال:
  /// await TokenStorage.saveToken('eyJhbGciOiJIUzI1NiIs...');
  static Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, token);
    } catch (e) {
      // معالجة الخطأ
      log('❌ Error saving access token: $e');
      rethrow;
    }
  }
  
  /// حفظ Refresh Token
  /// 
  /// [refreshToken] - الـ Refresh Token المراد حفظه
  /// 
  /// متى نستخدمها؟
  /// - بعد Login ناجح (السيرفر بيرجع access + refresh)
  /// - بعد تجديد Token (أحياناً السيرفر بيرجع refresh جديد)
  static Future<void> saveRefreshToken(String refreshToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshTokenKey, refreshToken);
    } catch (e) {
     log('❌ Error saving refresh token: $e');
      rethrow;
    }
  }
  
  /// حفظ الاثنين مع بعض
  /// 
  /// [accessToken] - Access Token
  /// [refreshToken] - Refresh Token
  /// 
  /// الفائدة: توفير وقت - بدل ما نستدعي دالتين
  /// 
  /// مثال:
  /// await TokenStorage.saveTokens(
  ///   accessToken: 'eyJhbGci...',
  ///   refreshToken: 'eyJhbGci...',
  /// );
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // حفظ الاثنين في نفس الوقت
      await Future.wait([
        prefs.setString(_accessTokenKey, accessToken),
        prefs.setString(_refreshTokenKey, refreshToken),
      ]);
    } catch (e) {
     log('❌ Error saving tokens: $e');
      rethrow;
    }
  }
  
  // ══════════════════════════════════════════════════════════════
  // استرجاع Tokens
  // ══════════════════════════════════════════════════════════════
  
  /// استرجاع Access Token
  /// 
  /// Returns: Token أو null لو مش موجود
  /// 
  /// متى نستخدمها؟
  /// - في كل request (في Dio Interceptor)
  /// - للتحقق من تسجيل دخول المستخدم
  /// 
  /// مثال:
  /// final token = await TokenStorage.getToken();
  /// if (token != null) {
  ///   // المستخدم مسجل دخول
  /// }
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_accessTokenKey);
    } catch (e) {
      log('❌ Error getting access token: $e');
      return null;
    }
  }
  
  /// استرجاع Refresh Token
  /// 
  /// Returns: Refresh Token أو null لو مش موجود
  /// 
  /// متى نستخدمها؟
  /// - عند تجديد Access Token
  static Future<String?> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshTokenKey);
    } catch (e) {
      log('❌ Error getting refresh token: $e');
      return null;
    }
  }
  
  // ══════════════════════════════════════════════════════════════
  // التحقق من وجود Token
  // ══════════════════════════════════════════════════════════════
  
  /// التحقق من وجود Access Token
  /// 
  /// Returns: true لو Token موجود، false لو مش موجود
  /// 
  /// الفائدة: أسرع من استرجاع Token كامل
  /// 
  /// متى نستخدمها؟
  /// - للتحقق السريع من حالة تسجيل الدخول
  /// - في Splash Screen
  /// 
  /// مثال:
  /// final isLoggedIn = await TokenStorage.hasToken();
  /// if (isLoggedIn) {
  ///   // اذهب للـ Home
  /// } else {
  ///   // اذهب للـ Login
  /// }
  static Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
  
  // ══════════════════════════════════════════════════════════════
  // حذف Tokens
  // ══════════════════════════════════════════════════════════════
  
  /// حذف Access Token فقط
  /// 
  /// متى نستخدمها؟
  /// - نادراً (عادةً نحذف الاثنين مع بعض)
  static Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
    } catch (e) {
  log('❌ Error clearing access token: $e');
      rethrow;
    }
  }
  
  /// حذف كل الـ Tokens
  /// 
  /// متى نستخدمها؟
  /// - عند Logout
  /// - عند انتهاء صلاحية Session
  /// - عند حذف الحساب
  /// 
  /// مثال:
  /// await TokenStorage.clearTokens();
  /// // المستخدم الآن logged out
  static Future<void> clearTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // حذف الاثنين في نفس الوقت
      await Future.wait([
        prefs.remove(_accessTokenKey),
        prefs.remove(_refreshTokenKey),
      ]);
    } catch (e) {
      log('❌ Error clearing tokens: $e');
      rethrow;
    }
  }
  
  // ══════════════════════════════════════════════════════════════
  // دوال إضافية مفيدة (اختياري)
  // ══════════════════════════════════════════════════════════════
  
  /// حفظ بيانات إضافية مع Token
  /// 
  /// مثال: حفظ User ID أو Username
  static Future<void> saveUserData({
    String? userId,
    String? username,
    String? email,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (userId != null) {
        await prefs.setString('user_id', userId);
      }
      if (username != null) {
        await prefs.setString('username', username);
      }
      if (email != null) {
        await prefs.setString('email', email);
      }
    } catch (e) {
      log('❌ Error saving user data: $e');
    }
  }
  
  /// استرجاع User ID
  static Future<String?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('user_id');
    } catch (e) {
      log('❌ Error geting user id: $e');

      return null;
    }
  }
  
  /// حذف كل بيانات المستخدم (Token + User Data)
  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // حذف كل المفاتيح المتعلقة بالـ auth
      await Future.wait([
        prefs.remove(_accessTokenKey),
        prefs.remove(_refreshTokenKey),
        prefs.remove('user_id'),
        prefs.remove('username'),
        prefs.remove('email'),
      ]);
    } catch (e) {
      log('❌ Error clearing all data: $e');
      rethrow;
    }
  }
}