import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/apiAgency/agencyBloc.dart';
import 'package:space_app/bloc/apiAstronaut/astronautBloc.dart';
import 'package:space_app/bloc/data/dataBloc.dart';
import 'package:space_app/bloc/apiIss/issBloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/routes/appRoutes.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/database/databaseBloc.dart';
import 'bloc/settings/settingsBloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SpaceApp());
}

class SpaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DatabaseBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => DataBloc()),
        BlocProvider(create: (_) => AstronautBloc()),
        BlocProvider(create: (_) => AgencyBloc()),
        BlocProvider(create: (_) => IssBloc()),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        routes: AppRoutes.routes,
        initialRoute: '/',
      ),
    );
  }
}
