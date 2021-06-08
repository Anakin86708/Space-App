import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/bloc/profile/profileStates.dart';

class Register extends StatefulWidget {
  final ProfileState state;
  final BuildContext context;
  const Register(this.context, this.state) : super();

  @override
  _RegisterState createState() => _RegisterState(context, state);
}

class _RegisterState extends State<Register> {
  final ProfileState state;
  final BuildContext context;
  final GlobalKey<FormState> formKey = new GlobalKey();
  final SendDataEvent data = SendDataEvent();

  _RegisterState(this.context, this.state) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailFormField(state),
            _passwordFormField(state),
            _generateLoginButton(this.context),
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

  Widget _generateLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            print('Pressed');
            BlocProvider.of<ProfileBloc>(context).add(data);
          }
        },
        child: Text("Log in!"));
  }
}