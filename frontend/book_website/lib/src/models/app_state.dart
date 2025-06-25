import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'user.dart';

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
}