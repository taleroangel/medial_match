import 'package:flutter/material.dart';
import 'package:medial_match/screens/home/home_screen.dart';
import 'package:medial_match/screens/users/user_management_screen.dart';

enum MainScreenDestinations {
  home(
    HomeScreen(),
    Icon(Icons.home_filled),
    "Inicio",
  ),
  userManagement(
    UserManagementScreen(),
    Icon(Icons.supervised_user_circle_rounded),
    "Usuario",
  ),
  ;

  final Widget view;
  final Icon icon;
  final String text;

  const MainScreenDestinations(this.view, this.icon, this.text);
}
