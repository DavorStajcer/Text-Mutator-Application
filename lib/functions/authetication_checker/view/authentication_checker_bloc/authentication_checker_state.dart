part of 'authentication_checker_bloc.dart';

abstract class AuthenticationCheckerState extends Equatable {
  const AuthenticationCheckerState();

  @override
  List<Object> get props => [];
}

class AuthenticationCheckerInitial extends AuthenticationCheckerState {}

class UserNotAuthenticated extends AuthenticationCheckerState {}

class UserAuthenticated extends AuthenticationCheckerState {}
