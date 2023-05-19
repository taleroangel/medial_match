import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:medial_match/mocks/mock_authentication_provider.dart';
import 'package:medial_match/screens/authentication/unauthenticated_screen.dart';
import 'package:medial_match/screens/main_screen.dart';
import 'package:medial_match/theme.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // Provides authentication to underlying widgets
          ChangeNotifierProvider<AbstractAuthenticationProvider>(
            create: (_) => MockAuthenticationProvider(kDebugMode),
          ),
        ],
        builder: (_, __) => MaterialApp(
          theme: applicationTheme(),
          home: Consumer<AbstractAuthenticationProvider>(
            builder: (_, provider, __) => provider.authenticated
                ? const MainScreen()
                : const UnauthenticatedScreen(),
          ),
        ),
      );
}
