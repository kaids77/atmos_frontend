import 'package:flutter/material.dart';

/// Simple in-memory auth state manager.
class AuthState extends ChangeNotifier {
  static final AuthState _instance = AuthState._internal();
  factory AuthState() => _instance;
  AuthState._internal();

  bool _isSignedIn = false;
  String? _userEmail;
  String? _displayName;

  bool get isSignedIn => _isSignedIn;
  String? get userEmail => _userEmail;
  String? get displayName => _displayName;

  void signIn(String email, {String? displayName}) {
    _isSignedIn = true;
    _userEmail = email;
    if (displayName != null && displayName.isNotEmpty) {
      _displayName = displayName;
    }
    notifyListeners();
  }

  void signOut() {
    _isSignedIn = false;
    _userEmail = null;
    _displayName = null;
    notifyListeners();
  }
}
