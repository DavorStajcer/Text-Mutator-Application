import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

class AuthCredentials extends Equatable {
  final EmailCredential emailCredential;
  final PasswordCredential passwordCredential;
  final PasswordConfirmCredential passwordConfirmCredential;

  AuthCredentials({
    required this.emailCredential,
    required this.passwordCredential,
    required this.passwordConfirmCredential,
  });

  bool isValid(bool isLogin) {
    bool _areAllInputsValid = (this.emailCredential.errorMessage == null &&
        this.passwordCredential.errorMessage == null);

    if (isLogin)
      _areAllInputsValid = _areAllInputsValid &&
          this.passwordConfirmCredential.errorMessage == null;

    print('form is valid?  :   ' + _areAllInputsValid.toString());
    return _areAllInputsValid;
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
  final String email;
  EmailCredential(
    String email,
  ) : this.email = email {
    errorMessage =
        EmailValidator.validate(email) ? null : 'email is not valid.';
  }

  EmailCredential.initial() : this.email = '' {
    errorMessage = null;
  }

  @override
  List<Object?> get props => [email, errorMessage];
}

class PasswordCredential extends Equatable {
  late final String? errorMessage;
  final String password;

  PasswordCredential(
    String password,
  ) : this.password = password {
    errorMessage = (password.length >= 8) ? null : 'Password si too short.';
  }

  PasswordCredential.initial() : this.password = '' {
    errorMessage = null;
  }

  @override
  List<Object?> get props => [password, errorMessage];
}

class PasswordConfirmCredential extends Equatable {
  late final String? errorMessage;
  final String confirmPassword;
  PasswordConfirmCredential(
    String password,
    String confirmPass,
  ) : this.confirmPassword = confirmPass {
    errorMessage = (password == confirmPass) ? null : 'Passwords do not match,';
  }

  PasswordConfirmCredential.initial() : this.confirmPassword = '' {
    errorMessage = null;
  }

  @override
  List<Object?> get props => [confirmPassword, errorMessage];
}
