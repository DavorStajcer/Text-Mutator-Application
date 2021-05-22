part of 'authentication_action_cubit.dart';

abstract class AuthenticationActionState extends Equatable {
  const AuthenticationActionState();

  @override
  List<Object> get props => [];
}

class AuthenticationActionLogin extends AuthenticationActionState {}

class AuthenticationActionSignup extends AuthenticationActionState {}
