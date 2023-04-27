import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:faker/faker.dart';

/// Generate mock [Service] for emulating database
class MockDatabaseService implements IDatabaseService {
  MockDatabaseService() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  /// Faker instance
  final _fakerInstance = Faker();
  final _randomInstance = Random();
  var _instanceCode = 0;

  /// Generate a MockService
  Service _mockService() {
    final randomLowerPrice = (_randomInstance.nextDouble() *
        (_randomInstance.nextInt(500000) + 20000));

    return Service(
      id: _instanceCode++,
      name: _fakerInstance.lorem.sentence(),
      description: _fakerInstance.lorem.sentences(10).reduce(
            (value, element) => "$value $element",
          ),
      priceLower: randomLowerPrice,
      priceUpper: randomLowerPrice + _randomInstance.nextInt(100000),
    );
  }

  // Generate number of mockup services
  late final Set<Service> _services =
      List.generate(10, (_) => _mockService()).toSet();

  @override
  Set<Service> get services => Set.unmodifiable(_services);
}
