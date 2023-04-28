// ignore_for_file: prefer-match-file-name

import 'package:flutter/foundation.dart';

abstract class IAuthenticationProvider extends ChangeNotifier {
  /// Check if user is authenticated
  bool get authenticated;

  /// Authenticate user with email and password
  Future<bool> authenticate(String email, String password);

  /// Sign Out of currently authenticated account
  void signOut();
}
