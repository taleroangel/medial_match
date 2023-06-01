import 'package:flutter/material.dart';
import 'package:medial_match/exceptions/authentication_exception.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/request.dart';
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

  void userCreateRequest(Request request);

  void userAcceptOffer(Request request, Offer offer);

  void message(Contract contract, String message);
}
