import 'package:flutter/material.dart';
import 'package:space_app/theme/appColors.dart';

class AppTheme {
  const AppTheme();

  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Comfortaa',
      accentColor: AppColors.accent,
      primarySwatch: AppColors.accent,
      primaryColorDark: AppColors.primary,
      backgroundColor: AppColors.primary.shade300,
      cardColor: AppColors.primary.shade50,
      primaryIconTheme: IconThemeData(color: AppColors.secondary),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: AppColors.secondary,
            fontFamily: 'Comfortaa',
            fontSize: 22,
          ),
        ).apply(),
        elevation: 2,
        backgroundColor: AppColors.primary.shade600,
        iconTheme: IconThemeData(color: AppColors.secondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.secondary,
          filled: true,
          labelStyle: TextStyle(color: AppColors.primary[900])),
      dividerColor: AppColors.accent,
    );
  }

  static get cardStyle {
    return {
      'titleStyle': TextStyle(color: AppColors.secondary, fontSize: 18),
      'textStyle': TextStyle(color: AppColors.secondary),
      'starColor': AppColors.accent,
    };
  }

  static get stylerDrawerText => TextStyle(fontSize: 24);
  static get postStyle => {
        "titleStyle": TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        "contentStyle": TextStyle(fontSize: 19),
        "contentJustify": TextAlign.justify
      };
}
