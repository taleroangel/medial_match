import 'package:flutter/material.dart';
import 'package:medial_match/providers/authentication_provider.dart';
import 'package:medial_match/providers/mock/mock_authentication_provider.dart';
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
          ChangeNotifierProvider<IAuthenticationProvider>(
            create: (_) => MockAuthenticationProvider(),
          ),
        ],
        builder: (_, __) => MaterialApp(
          theme: applicationTheme(),
          home: Consumer<IAuthenticationProvider>(
            builder: (_, provider, __) => provider.authenticated
                ? const MainScreen()
                : const UnauthenticatedScreen(),
          ),
        ),
      );
}
