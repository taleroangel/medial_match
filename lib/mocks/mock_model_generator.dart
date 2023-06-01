import 'dart:math';

import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/extensions/unix_time.dart';
import 'package:medial_match/mocks/mock_asset_loader.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/message.dart';
import 'package:medial_match/models/news.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/models/user.dart';

abstract class MockModelGenerator {
  // Instance counters
  static var _serviceInstanceCode = 0;
  static var _contractInstanceCode = 0;
  static var _requestInstanceCode = 0;

  // Fake providers
  static final _fakerInstance = Faker();
  static final _randomInstance = Random();

  // Services Stack
  static final serviceStack = GetIt.I.get<MockAssetLoader>().services;

  /// Generate a random price
  static double get mockPrice => (_randomInstance.nextDouble() *
      (_randomInstance.nextInt(500000) + 20000));

  /// Generate a Lorem Ipsum paragraph
  static String mockParagraph([int sentences = 5]) =>
      _fakerInstance.lorem.sentences(sentences).reduce(
            (value, element) => "$value $element",
          );

  /// Generate fake user
  static User mockUser({
    int contracts = 0,
    int requests = 0,
    int maxOffers = 0,
    UserType userType = UserType.client,
  }) =>
      User(
        id: _fakerInstance.randomGenerator.integer(1024),
        name: _fakerInstance.person.name(),
        type: userType,
        contracts: List.generate(
          contracts,
          (index) => mockContract,
        ).toSet(),
        requests: List.generate(
          requests,
          (index) => mockRequest(_randomInstance.nextInt(2) == 0
              ? _randomInstance.nextInt(maxOffers)
              : 0),
        ).toSet(),
        stars: _fakerInstance.randomGenerator.decimal(scale: 5.0),
        presentation: userType == UserType.freelancer ? mockParagraph() : null,
      );

  /// Generate a MockService
  static Service get mockService {
    final randomLowerPrice = mockPrice;

    return Service(
      id: _serviceInstanceCode++,
      name: _fakerInstance.lorem.sentence(),
      description: mockParagraph(10),
      priceLower: randomLowerPrice,
      priceUpper: randomLowerPrice + _randomInstance.nextInt(100000),
    );
  }

  /// Generate mock contract
  static Contract get mockContract => Contract(
        id: _contractInstanceCode++,
        service: serviceStack.elementAt(_fakerInstance.randomGenerator.integer(
          serviceStack.length,
        )),
        freelancer: mockUser(userType: UserType.freelancer),
        price: mockPrice,
        details: mockParagraph(2),
        createdAt:
            _fakerInstance.date.dateTime(minYear: 2023, maxYear: 2024).unixTime,
        dueAt:
            _fakerInstance.date.dateTime(minYear: 2023, maxYear: 2024).unixTime,
        chat: _randomInstance.nextInt(3) == 0
            ? []
            : List.generate(10, (index) => mockMessage(null)),
      );

  /// Generate mock news
  static News get mockNews => News(
        title: faker.lorem.sentence(),
        content: mockParagraph(10),
      );

  /// Generate mock offer
  static Offer get mockOffer => Offer(
        freelancer: mockUser(),
        price: mockPrice,
      );

  /// Generate a mock request
  static Request mockRequest([int offers = 0]) => Request(
        id: _requestInstanceCode++,
        date:
            _fakerInstance.date.dateTime(minYear: 2023, maxYear: 2024).unixTime,
        description: mockParagraph(2),
        offers: List.generate(offers, (_) => mockOffer).toSet(),
        service: serviceStack.elementAt(_fakerInstance.randomGenerator.integer(
          serviceStack.length,
        )),
        dueAt:
            _fakerInstance.date.dateTime(minYear: 2023, maxYear: 2024).unixTime,
      );

  static Message mockMessage(UserType? type) => Message(
        content: mockParagraph(1),
        who: type ?? (UserType.values.toList()..shuffle(_randomInstance)).first,
      );
}
