import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/providers/authentication_provider.dart';

class MockAuthenticationProvider extends IAuthenticationProvider {
  MockAuthenticationProvider() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  var _authenticationStatus = false;

  @override
  Future<bool> authenticate(String email, String password) async {
    _authenticationStatus = true;

    GetIt.I.get<Logger>().i("Authenticated successfully");
    notifyListeners();

    return _authenticationStatus;
  }

  @override
  bool get authenticated => _authenticationStatus;

  @override
  void signOut() {
    _authenticationStatus = false;
    notifyListeners();
  }
}
