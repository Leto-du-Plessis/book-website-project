import 'package:flutter/foundation.dart';

import 'auth_repository.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthNotifier(this._authRepository) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    _isLoggedIn = await _authRepository.isLoggedIn();
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    bool success = await _authRepository.login(username, password);
    if (success) {
      _isLoggedIn = true;
      notifyListeners();
    }
    return success;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _isLoggedIn = false;
    notifyListeners();
  }
}