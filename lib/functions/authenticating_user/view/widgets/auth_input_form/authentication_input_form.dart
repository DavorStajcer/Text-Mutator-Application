import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icon.dart';

import '../../../../authetication_checker/view/auth_form_bloc/auth_form_bloc.dart';
import '../../../../authetication_checker/view/authetication_action_cubit/authentication_action_cubit.dart';
import '../auth_text_button.dart';
import 'auth_form_button.dart';
import 'auth_input_field.dart';
import 'confirm_password_field_animation.dart';

class AuthenticationInputForm extends StatefulWidget {
  const AuthenticationInputForm({Key? key, required this.theme})
      : super(key: key);
  final ThemeData theme;

  @override
  _AuthenticationInputFormState createState() =>
      _AuthenticationInputFormState();
}

class _AuthenticationInputFormState extends State<AuthenticationInputForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 400,
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationActionCubit _authenticationActionCubit =
        BlocProvider.of<AuthenticationActionCubit>(context);
    final AuthFormBloc _authFormBloc = BlocProvider.of<AuthFormBloc>(context);

    return BlocConsumer<AuthenticationActionCubit, AuthenticationActionState>(
        listener: (ctx, authenticationActionState) {
      (authenticationActionState is AuthenticationActionSignup)
          ? _animationController.forward()
          : _animationController.reverse();
    }, builder: (ctx, authenticationActionState) {
      final bool _isLogin =
          (authenticationActionState is AuthenticationActionLogin);
      return BlocBuilder<AuthFormBloc, AuthFormState>(
        builder: (context, authFormState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AuthInputField(
                  theme: widget.theme,
                  errorMessage: authFormState
                      .authCredentials.emailCredential.errorMessage,
                  onChanged: (String email) =>
                      _authFormBloc.add(EmailChanged(email)),
                  highlitedBorder: _getNFocusedBorder(),
                  normalBorder: _getNormalBorder(),
                  title: 'email',
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                ),
                AuthInputField(
                  obscureText: true,
                  errorMessage: authFormState
                      .authCredentials.passwordCredential.errorMessage,
                  theme: widget.theme,
                  onChanged: (String password) =>
                      _authFormBloc.add(PasswordChanged(password)),
                  highlitedBorder: _getNFocusedBorder(),
                  normalBorder: _getNormalBorder(),
                  title: 'password',
                  textInputAction:
                      _isLogin ? TextInputAction.done : TextInputAction.next,
                ),
                if (kIsWeb)
                  Center(
                    child: ConfirmPasswordAnimatedField(
                        animationController: _animationController,
                        child: _buildConfirmPassowrd(
                            _authFormBloc, authFormState)),
                  ),
                if (!kIsWeb)
                  ConfirmPasswordAnimatedField(
                    animationController: _animationController,
                    child: _buildConfirmPassowrd(_authFormBloc, authFormState),
                  ),
                AuthFormButton(
                  authFormState: authFormState,
                  isLogin: _isLogin,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: AuthTextButton(
                    text: _isLogin
                        ? 'Create account?'
                        : 'Allready have an account?',
                    onTap: () =>
                        _authenticationActionCubit.changeAuthenitcationAction(),
                    textStyle: widget.theme.textTheme.bodyText1!,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildConfirmPassowrd(
      AuthFormBloc _authFormBloc, AuthFormState authFormState) {
    return AuthInputField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      theme: widget.theme,
      onChanged: (String confirmPassword) => _authFormBloc.add(
        PasswordConfirmChanged(
          authFormState.authCredentials.passwordCredential.password,
          confirmPassword,
        ),
      ),
      errorMessage:
          authFormState.authCredentials.passwordConfirmCredential.errorMessage,
      highlitedBorder: _getNFocusedBorder(),
      normalBorder: _getNormalBorder(),
      title: 'confirm password',
    );
  }

  OutlineInputBorder _getNormalBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          20,
        ),
      ),
      borderSide:
          BorderSide(width: 1, color: widget.theme.textTheme.bodyText1!.color!),
    );
  }

  OutlineInputBorder _getNFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          20,
        ),
      ),
      borderSide:
          BorderSide(width: 2, color: widget.theme.colorScheme.secondary),
    );
  }
}
