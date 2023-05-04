import 'package:flutter/material.dart';
import 'package:medial_match/screens/home/home_screen.dart';
import 'package:medial_match/screens/match/match_screen.dart';
import 'package:medial_match/screens/users/user_screen.dart';

enum MainScreenDestinations {
  home(
    HomeScreen(),
    Icon(Icons.home_filled),
    "Inicio",
  ),
  match(
    MatchScreen(),
    Icon(Icons.emoji_people_rounded),
    "Match",
  ),
  user(
    UserScreen(),
    Icon(Icons.supervised_user_circle_rounded),
    "Usuario",
  ),
  ;

  final Widget view;
  final Icon icon;
  final String text;

  const MainScreenDestinations(this.view, this.icon, this.text);

  static MainScreenDestinations whereType(Type type) =>
      MainScreenDestinations.values
          .firstWhere((element) => element.view.runtimeType == type);
}

class PageNavigationRequestNotification extends Notification {
  final Type pageType;
  const PageNavigationRequestNotification(this.pageType);
}
