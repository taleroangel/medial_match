import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/models/user.dart';
import 'package:medial_match/providers/authentication_provider.dart';

class MockAuthenticationProvider extends IAuthenticationProvider {
  MockAuthenticationProvider() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  static final _fakerInstance = Faker();

  static User get mockUser => User(
        id: _fakerInstance.randomGenerator.integer(1024),
        name: _fakerInstance.person.name(),
        type: UserType.client,
      );

  var _authenticationStatus = false;
  User? _currentUser;

  @override
  Future<User> authenticate(String email, String password) async {
    _authenticationStatus = true;
    _currentUser = mockUser;

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
