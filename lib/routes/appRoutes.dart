import 'package:flutter/material.dart';
import 'package:space_app/views/astronauts_page/astronautsPage.dart';
import 'package:space_app/views/initialLayout.dart';
import 'package:space_app/views/settings_page/settingsPage.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => InitialLayout(),
    '/settings': (context) => SettingsPage(),
    '/astronautas': (context) => AstronautsPage(),
    '/agências': (context) => null,
    '/eventos': (context) => null,
    '/ISS': (context) => null,
  };
}
