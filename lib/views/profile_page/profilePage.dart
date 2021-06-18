import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/model/userData.dart';

class ProfilePage extends StatelessWidget {
  final UserData user;

  const ProfilePage(this.user) : super();

  @override
  Widget build(BuildContext context) {
    print(user.uid);
    return Container(
      child: Column(
        children: [
          Text(user.uid),
          _logout(context),
        ],
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(Logout());
        },
        child: Text('Sair da conta'));
  }
}
