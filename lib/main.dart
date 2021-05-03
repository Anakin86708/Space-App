import 'package:flutter/material.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/bottomNavigationBarLayout.dart';

void main() {
  runApp(SpaceApp());
}

class SpaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: BottomNavegationBarLayout(),
    );
  }
}
