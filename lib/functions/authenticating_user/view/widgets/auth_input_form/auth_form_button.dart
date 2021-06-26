import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';
import '../../../../../core/constants/pages.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../auth_bloc/auth_bloc_bloc.dart';
import '../../../../authetication_checker/view/auth_form_bloc/auth_form_bloc.dart';

class AuthFormButton extends StatelessWidget {
  const AuthFormButton({
    Key? key,
    required this.authFormState,
    required bool isLogin,
  })  : _isLogin = isLogin,
        super(key: key);

  final AuthFormState authFormState;
  final bool _isLogin;

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authenticationBloc = BlocProvider.of<AuthBloc>(context);
    final UserDataBloc _userDataBloc = BlocProvider.of<UserDataBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, authState) {
          if (authState is AuthFailed)
            _authFailed(context, authState);
          else if (authState is AuthSuccesfull) {
            _authSuccess(_userDataBloc, authState, context);
          }
        },
        builder: (context, authState) {
          final bool _areAllInputsValid =
              _areAllInputFieldsValid(authFormState, _isLogin);
          return authState is AuthLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : AppButton(
                  text: _isLogin ? 'Login' : ' Signup',
                  isAvailable: _areAllInputsValid,
                  onTap: () => _tryToAuthenticateUser(
                    _areAllInputsValid,
                    context,
                    _authenticationBloc,
                  ),
                );
        },
      ),
    );
  }

  void _authSuccess(UserDataBloc _userDataBloc, AuthSuccesfull authState,
      BuildContext context) {
    _userDataBloc.add(LoadUserData());
    if (authState.isEmailSignIn) {
      Navigator.of(context).pushReplacementNamed(ROUTE_USERNAME_INPUT_PAGE);
    } else {
      Navigator.of(context).pushReplacementNamed(ROUTE_WELCOME_PAGE);
    }
  }

  void _authFailed(BuildContext context, AuthFailed authState) {
    if (!kIsWeb) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(authState.message)));
    }
  }

  void _tryToAuthenticateUser(bool _areAllInputsValid, BuildContext context,
      AuthBloc _authenticationBloc) {
    if (_areAllInputsValid) {
      FocusScope.of(context).unfocus();
      final String _userEmail =
          authFormState.authCredentials.emailCredential.email;

      final String _userPassword =
          authFormState.authCredentials.passwordCredential.password;

      _isLogin
          ? _authenticationBloc.add(
              LogIn(
                _userEmail,
                _userPassword,
              ),
            )
          : _authenticationBloc.add(
              SignUp(
                _userEmail,
                _userPassword,
              ),
            );
    }
  }

  bool _areAllInputFieldsValid(AuthFormState authFormState, bool isLogin) {
    return (authFormState.authCredentials.isValid(isLogin) &&
        !(authFormState is AuthFormInitial));
  }
}
