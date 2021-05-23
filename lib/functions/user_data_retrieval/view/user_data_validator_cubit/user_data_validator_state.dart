part of 'user_data_validator_cubit.dart';

abstract class UserDataValidatorState extends Equatable {
  const UserDataValidatorState(this.errorMessage, this.username);
  final String? errorMessage;
  final String username;

  @override
  List<Object?> get props => [username, errorMessage];
}

class UserDataValid extends UserDataValidatorState {
  UserDataValid(final String username) : super(null, username);
}

class UserDataNotValid extends UserDataValidatorState {
  UserDataNotValid(String? message, final String username)
      : super(message, username);
}
