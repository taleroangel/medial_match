import 'dart:math';

import 'package:faker/faker.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/news.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/models/user.dart';

abstract class MockModelGenerator {
  // Instance counters
  static var _serviceInstanceCode = 0;
  static var _contractInstanceCode = 0;

  // Fake providers
  static final _fakerInstance = Faker();
  static final _randomInstance = Random();

  /// Generate a random price
  static double get mockPrice => (_randomInstance.nextDouble() *
      (_randomInstance.nextInt(500000) + 20000));

  /// Generate a Lorem Ipsum paragraph
  static String get mockParagraph => _fakerInstance.lorem.sentences(10).reduce(
        (value, element) => "$value $element",
      );

  /// Generate fake user
  static User mockUser([int contracts = 0, int requests = 0, int offers = 0]) =>
      User(
        id: _fakerInstance.randomGenerator.integer(1024),
        name: _fakerInstance.person.name(),
        type: UserType.client,
        contracts: List.generate(contracts, (index) => mockContract).toSet(),
        requests:
            List.generate(requests, (index) => mockRequest(offers)).toSet(),
      );

  /// Generate a MockService
  static Service get mockService {
    final randomLowerPrice = mockPrice;

    return Service(
      id: _serviceInstanceCode++,
      name: _fakerInstance.lorem.sentence(),
      description: mockParagraph,
      priceLower: randomLowerPrice,
      priceUpper: randomLowerPrice + _randomInstance.nextInt(100000),
    );
  }

  /// Generate mock contract
  static Contract get mockContract => Contract(
        id: _contractInstanceCode++,
        freelancer: mockUser(),
        service: mockService,
        price: mockPrice,
        details: mockParagraph,
        createdAt: _fakerInstance.date.dateTime().millisecondsSinceEpoch,
        dueAt: _fakerInstance.date.dateTime().millisecondsSinceEpoch,
      );

  /// Generate mock news
  static News get mockNews => News(
        title: faker.lorem.sentence(),
        content: mockParagraph,
      );

  /// Generate mock offer
  static Offer get mockOffer => Offer(
        freelancer: mockUser(),
        price: mockPrice,
      );

  /// Generate a mock request
  static Request mockRequest([int offers = 0]) => Request(
        service: mockService,
        offers: List.generate(offers, (_) => mockOffer).toSet(),
      );
}
