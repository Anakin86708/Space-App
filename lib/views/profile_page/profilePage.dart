import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/model/userData.dart';
import 'package:space_app/theme/themeData.dart';

class ProfilePage extends StatelessWidget {
  final UserData user;

  const ProfilePage(this.user) : super();

  @override
  Widget build(BuildContext context) {
    print(user.uid);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Account email:', style: AppTheme.ProfileTitle,),
          Text(user.email, style: AppTheme.ProfileTitle,),
          Text('Account id: ${user.uid}', style:  AppTheme.ProfileID,),
          Divider(),
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
