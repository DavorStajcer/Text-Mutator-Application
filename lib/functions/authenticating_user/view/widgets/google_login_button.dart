import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:text_mutator/functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';

class GoogleLogInButton extends StatelessWidget {
  const GoogleLogInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return SignInButton(
      Buttons.Google,
      onPressed: () => _authBloc.add(LogInGoogle()),
    );
  }
}
