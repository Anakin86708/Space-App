import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/bottomNavigationBarLayout.dart';

import 'bloc/database/databaseBloc.dart';
import 'bloc/settings/settingsBloc.dart';

void main() {
  runApp(SpaceApp());
}

class SpaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => DatabaseBloc()),
            BlocProvider(create: (_) => SettingsBloc()),
          ],
          child: MaterialApp(
        theme: AppTheme.theme,
        home: BottomNavegationBarLayout(),
      ),
    );
  }
}
