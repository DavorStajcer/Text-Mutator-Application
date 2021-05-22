part of 'authentication_checker_bloc.dart';

abstract class AuthenticationCheckerEvent extends Equatable {
  const AuthenticationCheckerEvent();
}

class AuthenticationStateChanged extends AuthenticationCheckerEvent {
  final bool isLogedIn;

  AuthenticationStateChanged(this.isLogedIn);

  @override
  List<Object> get props => [isLogedIn];
}
