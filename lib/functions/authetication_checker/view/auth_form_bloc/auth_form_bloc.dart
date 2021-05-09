import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_mutator/functions/authetication_checker/domain/models/auth_credentials.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  AuthFormBloc()
      : super(AuthFormInitial(AuthCredentials(
          emailCredential: EmailCredential.initial(),
          passwordConfirmCredential: PasswordConfirmCredential.initial(),
          passwordCredential: PasswordCredential.initial(),
        )));

  @override
  Stream<AuthFormState> mapEventToState(
    AuthFormEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield AuthFormChanged(state.authCredentials
          .copyWith(emailCredential: EmailCredential(event.email)));
    } else if (event is PasswordChanged) {
      yield AuthFormChanged(state.authCredentials
          .copyWith(passwordCredential: PasswordCredential(event.password)));
    } else if (event is PasswordConfirmChanged) {
      yield AuthFormChanged(state.authCredentials.copyWith(
          passwordConfirmCredential: PasswordConfirmCredential(
        event.password,
        event.confirmPass,
      )));
    }
  }
}
