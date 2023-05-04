class AuthenticationException implements Exception {
  final String what;
  const AuthenticationException(this.what);

  @override
  String toString() => "Failed authentication: $what";
}
