import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCredentials extends Equatable {
  final EmailCredential emailCredential;
  final PasswordCredential passwordCredential;
  final PasswordConfirmCredential passwordConfirmCredential;

  AuthCredentials({
    required this.emailCredential,
    required this.passwordCredential,
    required this.passwordConfirmCredential,
  });

  bool isValid() {
    return (this.emailCredential.errorMessage != null &&
        this.passwordCredential.errorMessage != null &&
        this.passwordConfirmCredential.errorMessage != null);
  }

  AuthCredentials copyWith({
    EmailCredential? emailCredential,
    PasswordCredential? passwordCredential,
    PasswordConfirmCredential? passwordConfirmCredential,
  }) {
    return AuthCredentials(
      emailCredential: emailCredential ?? this.emailCredential,
      passwordCredential: passwordCredential ?? this.passwordCredential,
      passwordConfirmCredential:
          passwordConfirmCredential ?? this.passwordConfirmCredential,
    );
  }

  @override
  List<Object?> get props => [
        this.emailCredential,
        this.passwordCredential,
        this.passwordConfirmCredential
      ];
}

class EmailCredential extends Equatable {
  late final String? errorMessage;

  EmailCredential(
    String email,
  ) {
    errorMessage =
        EmailValidator.validate(email) ? null : 'email is not valid.';
  }

  EmailCredential.initial() {
    errorMessage = null;
  }

  @override
  List<Object?> get props => [errorMessage];
}

class PasswordCredential extends Equatable {
  late final String? errorMessage;

  PasswordCredential(
    String password,
  ) {
    errorMessage = (password.length >= 8) ? null : 'Password si too short.';
  }

  PasswordCredential.initial() {
    errorMessage = null;
  }

  @override
  List<Object?> get props => [errorMessage];
}

class PasswordConfirmCredential extends Equatable {
  late final String? errorMessage;
  PasswordConfirmCredential(
    String password,
    String confirmPass,
  ) {
    errorMessage = (password == confirmPass) ? null : 'Passwords do not match,';
  }

  PasswordConfirmCredential.initial() {
    errorMessage = null;
  }

  @override
  List<Object?> get props => [errorMessage];
}
