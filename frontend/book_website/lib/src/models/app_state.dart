import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'user.dart';

/// Stores the top level state information for the application. 
/// The currentIndex getter fetches the current page of the application.
/// The username getter fetches the username of the user and returns 'User' if null.
/// The profileImageBytes getter fetches the raw byte string of the user's profile image and can be null.
class AppState extends ChangeNotifier {

  int _currentPageIndex = 0;
  User? _user;
  
  int get currentIndex => _currentPageIndex;

  String get username => _user?.username ?? 'User';

  Uint8List? get profileImageBytes => _user?.profileImageBytes;

  void setPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}