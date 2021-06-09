import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';

class GoogleLogInButton extends StatelessWidget {
  const GoogleLogInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return GestureDetector(
      onTap: () => _authBloc.add(LogInGoogle()),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: null,
      ),
    );
  }
}
