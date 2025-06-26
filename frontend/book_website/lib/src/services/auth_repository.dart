import 'dart:convert';

import 'package:http/http.dart' as http;

import 'token_manager.dart';

class AuthRepository {

  final String baseUrl = 'http://127.0.0.1:8000';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/token"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: { 
        "username": username,
        "password": password,
      }
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      final token = data["access_token"];

      await TokenManager.saveToken(token);
      return true;

    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    bool hasToken = await TokenManager.hasToken();
    return hasToken;
  }

  Future<void> logout() async {
    await TokenManager.clearToken();
  }

  Future<String?> getToken() async {
    final String? token = await TokenManager.getToken();
    return token;
  }

}