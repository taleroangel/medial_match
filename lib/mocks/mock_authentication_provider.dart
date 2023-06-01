import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/mocks/mock_model_generator.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/message.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/models/user.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';

class MockAuthenticationProvider extends AbstractAuthenticationProvider {
  MockAuthenticationProvider([bool initAuthenticated = false]) {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType${initAuthenticated ? ' (as Authenticated)' : ''}",
        );

    if (initAuthenticated) {
      authenticate("", "");
    }
  }

  var _authenticationStatus = false;
  User? _currentUser;

  @override
  Future<User> authenticate(String email, String password) async {
    _authenticationStatus = true;
    _currentUser = MockModelGenerator.mockUser(
      contracts: 0,
      requests: 0,
      maxOffers: 0,
    );
    GetIt.I.get<Logger>().i(
          "[Mock] Authenticated successfully: $email",
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

  @override
  void userCreateRequest(Request request) {
    // Alter user
    _currentUser = user!.copyWith(requests: {request, ...user!.requests});
    notifyListeners();

    // Create future response
    Future.delayed(const Duration(seconds: 5), () {
      request = request.copyWith(offers: {
        ...List.generate(
          Random().nextInt(10),
          (_) => MockModelGenerator.mockOffer,
        ),
        ...request.offers,
      });

      _currentUser = user!.copyWith(requests: {
        request,
        ...user!.requests,
      });

      // Crear la notificación
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: "match_notification",
          title: "Es un match!",
          body: "Alguien ha ofertado en tu solicitud",
        ),
      );

      GetIt.I.get<Logger>().d("Generated service offer");
      notifyListeners();
    });
  }

  @override
  void userAcceptOffer(Request request, Offer offer) {
    // Create the contract
    final contract = Contract(
      createdAt: request.date,
      details: request.description,
      dueAt: request.dueAt,
      freelancer: offer.freelancer,
      id: Random().nextInt(1024),
      price: offer.price,
      service: request.service,
      chat: List.empty(),
    );

    // Update the user
    _currentUser = _currentUser!.copyWith(
      requests: _currentUser!.requests.difference({request}),
      contracts: {contract, ..._currentUser!.contracts},
    );

    notifyListeners();
  }

  @override
  void message(Contract contract, String message) {
    // Add message
    contract = contract.copyWith(chat: [
      ...contract.chat,
      Message(content: message, who: UserType.client),
    ]);

    _currentUser = _currentUser!
        .copyWith(contracts: {contract, ..._currentUser!.contracts});

    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      contract = contract.copyWith(chat: [
        MockModelGenerator.mockMessage(UserType.freelancer),
        ...contract.chat,
      ]);

      _currentUser = _currentUser!
          .copyWith(contracts: {contract, ..._currentUser!.contracts});

      notifyListeners();
    });
  }
}
