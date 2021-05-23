import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, authState) {
          if (authState is AuthFailed)
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(authState.message)));
          else if (authState is AuthSuccesfull)
            Navigator.of(context).pushReplacementNamed(
                _isLogin ? ROUTE_WELCOME_PAGE : ROUTE_USERNAME_INPUT_PAGE);
        },
        builder: (context, authState) {
          return authState is AuthLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : AppButton(
                  text: _isLogin ? 'Login' : ' Signup',
                  onTap: () {
                    if (_areAllInputFieldsValid(authFormState, _isLogin)) {
                      FocusScope.of(context).unfocus();
                      final String _userEmail =
                          authFormState.authCredentials.emailCredential.email;

                      final String _userPassword = authFormState
                          .authCredentials.passwordCredential.password;

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
                  },
                );
        },
      ),
    );
  }

  bool _areAllInputFieldsValid(AuthFormState authFormState, bool isLogin) {
    return (authFormState.authCredentials.isValid(isLogin) &&
        !(authFormState is AuthFormInitial));
  }
}
