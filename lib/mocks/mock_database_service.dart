import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/mocks/mock_model_generator.dart';
import 'package:medial_match/models/news.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/services/database_service.dart';

/// Generate mock [Service] for emulating database
class MockDatabaseService implements IDatabaseService {
  MockDatabaseService() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  // Generate number of mockup services
  late final Set<Service> _services = MockModelGenerator.serviceStack;

  // Generate number of mockup news
  late final Set<News> _news =
      List.generate(5, (_) => MockModelGenerator.mockNews).toSet();

  @override
  Set<Service> get services => Set.unmodifiable(_services);

  @override
  Set<News> get news => Set.unmodifiable(_news);
}
