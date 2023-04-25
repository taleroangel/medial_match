import 'package:flutter/material.dart';
import 'package:medial_match/screens/service_select_screen.dart';
import 'package:medial_match/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: applicationTheme(),
        home: const ServiceSelectScreen(),
      );
}
