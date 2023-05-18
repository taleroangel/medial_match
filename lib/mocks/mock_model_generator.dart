import 'dart:math';

import 'package:faker/faker.dart';
import 'package:medial_match/extensions/unix_time.dart';
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
  static String mockParagraph([int sentences = 5]) =>
      _fakerInstance.lorem.sentences(sentences).reduce(
            (value, element) => "$value $element",
          );

  /// Generate fake user
  static User mockUser({
    int contracts = 0,
    int requests = 0,
    int offers = 0,
    UserType userType = UserType.client,
  }) =>
      User(
        id: _fakerInstance.randomGenerator.integer(1024),
        name: _fakerInstance.person.name(),
        type: userType,
        contracts: List.generate(contracts, (index) => mockContract).toSet(),
        requests:
            List.generate(requests, (index) => mockRequest(offers)).toSet(),
        stars: _fakerInstance.randomGenerator.decimal(scale: 5.0),
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
        freelancer: mockUser(userType: UserType.freelancer),
        service: mockService,
        price: mockPrice,
        details: mockParagraph(2),
        createdAt:
            _fakerInstance.date.dateTime(minYear: 2023, maxYear: 2024).unixTime,
        dueAt:
            _fakerInstance.date.dateTime(minYear: 2023, maxYear: 2024).unixTime,
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
        service: mockService,
        offers: List.generate(offers, (_) => mockOffer).toSet(),
      );
}
