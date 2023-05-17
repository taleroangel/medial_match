import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:medial_match/screens/main_screen_destinations.dart';
import 'package:medial_match/screens/match/match_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageController = PageController();
  var currentPageIndex = 0;

  void navigateToPage(int index) {
    setState(() {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (value) => setState(() => currentPageIndex = value),
          children: MainScreenDestinations.values
              .map((e) =>
                  NotificationListener<PageNavigationRequestNotification>(
                    child: e.view,
                    onNotification: (pageNavigationNotification) {
                      // Navigate to that page
                      navigateToPage(MainScreenDestinations.whereType(
                        pageNavigationNotification.pageType,
                      ).index);

                      return true;
                    },
                  ))
              .toList(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (value) => navigateToPage(value),
          destinations: MainScreenDestinations.values
              .map((e) => NavigationDestination(
                    icon: Badge.count(
                      count: context
                          .read<AbstractAuthenticationProvider>()
                          .user!
                          .requests
                          .length,
                      isLabelVisible: e.view is MatchScreen,
                      child: e.icon,
                    ),
                    label: e.text,
                  ))
              .toList(),
        ),
      );
}
