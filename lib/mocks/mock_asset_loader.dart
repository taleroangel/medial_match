import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:medial_match/models/service.dart';

class MockAssetLoader {
  static Future<MockAssetLoader> getInstance() async => MockAssetLoader._(
        (jsonDecode(await rootBundle.loadString('assets/mock/services.json'))
                as List)
            .map((e) => Service.fromJson(e))
            .toSet(),
      );

  final Set<Service> services;
  MockAssetLoader._(this.services);
}
