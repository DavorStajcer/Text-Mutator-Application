//@dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:text_mutator/functions/authetication_checker/domain/models/auth_credentials.dart';
import 'package:text_mutator/functions/authetication_checker/view/auth_form_bloc/auth_form_bloc.dart';

void main() {
  final _testEmail = 'test';
  final _testPassword = 'testPass';
  final _testConfirmPassowrd = 'testConfrimPass';

  final _testCredentials = AuthCredentials(
    emailCredential: EmailCredential.initial(),
    passwordConfirmCredential: PasswordConfirmCredential.initial(),
    passwordCredential: PasswordCredential.initial(),
  );

  final _testEmailCred = EmailCredential(_testEmail);
  final _testPassCres = PasswordCredential(_testPassword);
  final _testPassConfirmCred =
      PasswordConfirmCredential(_testPassword, _testConfirmPassowrd);

  blocTest(
    'should emit AuthFormChanged with correct credentials when email changed',
    build: () => AuthFormBloc(),
    act: (bloc) => bloc.add(EmailChanged(_testEmail)),
    expect: () => [
      AuthFormChanged(AuthCredentials(
        emailCredential: _testEmailCred,
        passwordCredential: PasswordCredential.initial(),
        passwordConfirmCredential: PasswordConfirmCredential.initial(),
      ))
    ],
  );

  blocTest(
    'should emit AuthFormChanged with correct credentials when password cofnirmed changed',
    build: () => AuthFormBloc(),
    act: (bloc) => bloc.add(PasswordChanged(_testPassword)),
    expect: () => [
      AuthFormChanged(AuthCredentials(
        emailCredential: EmailCredential.initial(),
        passwordCredential: _testPassCres,
        passwordConfirmCredential: PasswordConfirmCredential.initial(),
      ))
    ],
  );

  blocTest(
    'should emit AuthFormChanged with correct credentials when password changed',
    build: () => AuthFormBloc(),
    act: (bloc) =>
        bloc.add(PasswordConfirmChanged(_testPassword, _testConfirmPassowrd)),
    expect: () => [
      AuthFormChanged(AuthCredentials(
        emailCredential: EmailCredential.initial(),
        passwordCredential: PasswordCredential.initial(),
        passwordConfirmCredential: _testPassConfirmCred,
      ))
    ],
  );
}
