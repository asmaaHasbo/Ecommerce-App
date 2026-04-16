// lib/core/storage/token_storage.dart

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

///
class TokenStorage {
  static const String _accessTokenKey = 'access_token';

  static const String _refreshTokenKey = 'refresh_token';

  TokenStorage._();

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

  static Future<void> saveRefreshToken(String refreshToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshTokenKey, refreshToken);
    } catch (e) {
      log('❌ Error saving refresh token: $e');
      rethrow;
    }
  }

  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_accessTokenKey);
    } catch (e) {
      log('❌ Error getting access token: $e');
      return null;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshTokenKey);
    } catch (e) {
      log('❌ Error getting refresh token: $e');
      return null;
    }
  }

  static Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
    } catch (e) {
      log('❌ Error clearing access token: $e');
      rethrow;
    }
  }

  static Future<void> saveUserData({
    String? userId,
    String? username,
    String? email,
    String? phone,
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
      if (phone != null) {
        await prefs.setString('phone', phone);
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
