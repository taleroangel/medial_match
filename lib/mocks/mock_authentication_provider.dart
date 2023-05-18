import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/mocks/mock_model_generator.dart';
import 'package:medial_match/models/user.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';

class MockAuthenticationProvider extends AbstractAuthenticationProvider {
  MockAuthenticationProvider() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  var _authenticationStatus = false;
  User? _currentUser;

  @override
  Future<User> authenticate(String email, String password) async {
    _authenticationStatus = true;
    _currentUser = MockModelGenerator.mockUser(
      contracts: 10,
      offers: 5,
      requests: 5,
    );

    GetIt.I.get<Logger>().i(
          "Authenticated successfully\n[email: $email, password: $password]",
        );

    notifyListeners();

    return _currentUser!;
  }

  @override
  Future<bool> forgotPassword(String email) {
    GetIt.I.get<Logger>().i(
          "$email: Forgot password prompted",
        );

    return Future.value(true);
  }

  @override
  bool get authenticated => _authenticationStatus;

  @override
  void signOut() {
    _authenticationStatus = false;
    notifyListeners();
  }

  @override
  User? get user => _currentUser;
}
