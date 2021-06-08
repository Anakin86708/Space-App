import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/bloc/profile/profileStates.dart';
import 'package:space_app/theme/appColors.dart';
import 'package:space_app/views/interfacePage.dart';
import 'package:space_app/views/profile_page/profilePage.dart';

class WrapperProfile extends StatelessWidget implements InterfacePage {
  final GlobalKey<FormState> formKey = new GlobalKey();
  final SendDataEvent data = SendDataEvent();

  @override
  Icon get pageIcon => Icon(Icons.person);

  @override
  String get pageName => "Perfil";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        print(state);
        if (state is LoggedState) {
          return ProfilePage(state.user);
        }
        return _buildFormInterface(context, state);
      },
      listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Erro do Servidor"),
                  content: Text("${state.message}"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"))
                  ],
                );
              });
        }
      },
    );
  }

  Widget _buildFormInterface(BuildContext context, ProfileState state) {
    return Container(
        child: Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailFormField(state),
            _passwordFormField(state),
            _generateFormButton(context, state),
            Divider(thickness: 2),
            _generateChangeText(context, state),
            _generateChangeButton(context, state),
          ],
        ),
      ),
    ));
  }

  Widget _emailFormField(ProfileState state) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(labelText: "E-mail", hintText: "usuario@gmail.com"),
        onSaved: (String userValue) {
          data.email = userValue;
        },
      ),
    );
  }

  Widget _passwordFormField(ProfileState state) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: "Password"),
        obscureText: true,
        onSaved: (String userValue) {
          data.password = userValue;
        },
        validator: (value) =>
            value.length >= 6 ? null : 'Senha deve ter ao menos 6 caracteres',
      ),
    );
  }

  Widget _generateFormButton(BuildContext context, ProfileState state) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('Pressed');
          BlocProvider.of<ProfileBloc>(context).add(data);
        }
      },
      child: state is LogState ? Text("Login") : Text("Registrar"),
    );
  }

  Widget _generateChangeText(BuildContext context, ProfileState state) {
    TextStyle style = TextStyle(color: AppColors.secondary);
    return state is LogState
        ? Text('Ainda não tem uma conta?', style: style)
        : Text('Já possui uma conta?', style: style);
  }

  Widget _generateChangeButton(BuildContext context, ProfileState state) {
    return ElevatedButton(
      onPressed: () {
        ProfileEvent event =
            state is LogState ? ChangeToRegisterEvent() : ChangeToLoginEvent();
        print('Changing state to $event');
        print('Current state $state');
        BlocProvider.of<ProfileBloc>(context).add(event);
      },
      child: state is LogState ? Text("Criar uma") : Text("Realizar login"),
    );
  }
}
