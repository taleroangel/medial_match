import 'package:flutter/material.dart';
import 'package:medial_match/exceptions/authentication_exception.dart';
import 'package:medial_match/models/user.dart';

abstract class AbstractAuthenticationProvider extends ChangeNotifier {
  /// Check if user is authenticated
  bool get authenticated;

  /// Get currently authenticated user
  User? get user;

  /// Authenticate user with email and password
  /// Returns the currently logged [User]
  /// Throws [AuthenticationException] on failure
  Future<User> authenticate(String email, String password);

  /// Forgot password
  Future<bool> forgotPassword(String email);

  /// Sign Out of currently authenticated account
  void signOut();
}
