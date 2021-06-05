import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileStates.dart';
import 'package:space_app/views/interfacePage.dart';

class WrapperProfile extends StatelessWidget implements InterfacePage {
  @override
  Icon get pageIcon => Icon(Icons.person);

  @override
  String get pageName => "Perfil";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return _buildFormInterface(context, state);
        },
        listener: (context, state) {});
  }
}

Widget _buildFormInterface(BuildContext context, ProfileState state) {
  return Container();
}
