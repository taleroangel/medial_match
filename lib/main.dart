import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/application.dart';
import 'package:medial_match/mocks/mock_asset_loader.dart';
import 'package:medial_match/services/image_storage_service.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/mocks/mock_database_service.dart';
import 'package:medial_match/mocks/mock_image_storage_service.dart';
import 'package:medial_match/theme.dart';

void main() async {
  // Register Logging
  GetIt.I.registerSingleton(
    Logger(
      level: kDebugMode ? Level.verbose : Level.warning,
      printer: kDebugMode ? PrettyPrinter() : SimplePrinter(),
    ),
  );

  // Enable notifications
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'match_notification_group',
        channelKey: 'match_notification',
        channelName: 'Es un match!',
        channelDescription: 'Notificaciones de matches',
        defaultColor: medialMatchPrimary,
        ledColor: Colors.white,
      ),
    ],
    debug: kDebugMode,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Register mock services
    GetIt.I.registerSingletonAsync(MockAssetLoader.getInstance);

    // Register Services Dependencies
    GetIt.I.registerSingleton<IImageStorageService>(MockImageStorageService());
    GetIt.I.registerSingleton<IDatabaseService>(MockDatabaseService());

    // Wait for GetIt Dependencies
    await GetIt.I.allReady();
    GetIt.I.get<Logger>().d(
          "All dependencies are ready",
        );

    // Run the application
    runApp(const Application());
  } catch (e) {
    // Show logging error uncaught exception
    GetIt.I.get<Logger>().wtf(
          "[${e.runtimeType}] Failed application initialization due to: $e",
        );
  }
}
