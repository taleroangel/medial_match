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

  /// Generate a MockService
  Service _mockService() {
    GetIt.I.get<Logger>().v("Generating mock service");

    return Service(
      id: _fakerInstance.randomGenerator.integer(1024),
      name: _fakerInstance.lorem.sentence(),
      description: _fakerInstance.lorem.sentences(20).reduce(
            (value, element) => "$value $element",
          ),
    );
  }

  // Generate number of mockup services
  late final Set<Service> _services =
      List.generate(10, (_) => _mockService()).toSet();

  @override
  Set<Service> get services => Set.unmodifiable(_services);
}
