import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const _options = SharedPreferencesWithCacheOptions( 
    allowList: <String>{'authToken'},
  );

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferencesWithCache.create(cacheOptions: _options);
    await prefs.setString('authToken', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferencesWithCache.create(cacheOptions: _options);
    return prefs.getString('authToken');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferencesWithCache.create(cacheOptions: _options);
    await prefs.remove('authToken');
  }
}