import 'package:flutter/material.dart';
import 'package:space_app/model/postData.dart';
import 'package:space_app/views/agency_page/agenciesGrid.dart';
import 'package:space_app/views/astronauts_page/astronautsGrid.dart';
import 'package:space_app/views/initialLayout.dart';
import 'package:space_app/views/iss_page/issPage.dart';
import 'package:space_app/views/post_page/postPage.dart';
import 'package:space_app/views/settings_page/settingsPage.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => InitialLayout(),
    '/settings': (context) => SettingsPage(),
    '/astronauts': (context) => AstronautsGrid(),
    '/agencies': (context) => AgenciesGrid(),
    '/ISS': (context) => IssPage(),
  };
}
