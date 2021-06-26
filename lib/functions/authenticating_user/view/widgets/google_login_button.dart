import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../auth_bloc/auth_bloc_bloc.dart';
import '../../../theme_managment/cubit/theme_changing_cubit.dart';

class GoogleLogInButton extends StatelessWidget {
  const GoogleLogInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
      builder: (context, themeState) {
        return SignInButton(
          themeState.isLight ? Buttons.Google : Buttons.GoogleDark,
          shape: RoundedRectangleBorder(),
          onPressed: () => _authBloc.add(
            LogInGoogle(),
          ),
        );
      },
    );
  }
}
