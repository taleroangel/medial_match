import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/application.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/services/mock/mock_database_service.dart';

void main() async {
  // Register dependencies
  GetIt.I.registerSingleton<IDatabaseService>(MockDatabaseService());

  // Wait for GetIt Dependencies
  await GetIt.I.allReady();

  // Run the application
  runApp(const Application());
}
