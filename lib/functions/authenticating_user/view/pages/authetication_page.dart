import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../widgets/auth_input_form/authentication_input_form.dart';
import '../widgets/google_login_button.dart';
import '../../../authetication_checker/view/auth_form_bloc/auth_form_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: SingleChildScrollView(
        child: kIsWeb
            ? _buildWeb(_deviceSize, _theme)
            : _buildMobile(_deviceSize, _theme),
      ),
    );
  }

  Widget _buildWeb(Size deviceSize, ThemeData theme) {
    return Container(
      alignment: Alignment.center,
      height: 1000,
      width: deviceSize.width,
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                'Welcome to Mutext!',
                textAlign: TextAlign.left,
                style: theme.textTheme.headline1!.copyWith(letterSpacing: 1.64),
                maxLines: 1,
              ),
            ),
          ),
          Flexible(
            flex: 11,
            child: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => GetIt.I<AuthFormBloc>(),
              ),
            ], child: AuthenticationInputForm(theme: theme)),
          ),
          Flexible(
            flex: 1,
            child: GoogleLogInButton(),
          )
        ],
      ),
    );
  }

  Widget _buildMobile(Size _deviceSize, ThemeData _theme) {
    return SizedBox(
      height: _deviceSize.height,
      width: _deviceSize.width,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Welcome Back!',
                    textAlign: TextAlign.left,
                    style: _theme.textTheme.headline1,
                    maxLines: 1,
                  ),
                ),
              ),
              Flexible(
                flex: 11,
                child: MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => GetIt.I<AuthFormBloc>(),
                  ),
                ], child: AuthenticationInputForm(theme: _theme)),
              ),
              Flexible(
                flex: 1,
                child: GoogleLogInButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
