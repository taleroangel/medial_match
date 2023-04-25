import 'package:medial_match/models/service.dart';
import 'package:medial_match/services/database_service.dart';

class MockDatabaseService implements IDatabaseService {
  // Generate number of mockup services
  late final Set<Service> _services =
      List.generate(10, (_) => Service.mock()).toSet();

  @override
  Set<Service> get services => Set.unmodifiable(_services);
}
