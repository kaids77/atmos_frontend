import 'package:flutter/material.dart';

/// Simple in-memory auth state manager.
/// Replace with Firebase auth state later.
class AuthState extends ChangeNotifier {
  static final AuthState _instance = AuthState._internal();
  factory AuthState() => _instance;
  AuthState._internal();

  bool _isSignedIn = false;
  String? _userEmail;

  bool get isSignedIn => _isSignedIn;
  String? get userEmail => _userEmail;

  void signIn(String email) {
    _isSignedIn = true;
    _userEmail = email;
    notifyListeners();
  }

  void signOut() {
    _isSignedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}
