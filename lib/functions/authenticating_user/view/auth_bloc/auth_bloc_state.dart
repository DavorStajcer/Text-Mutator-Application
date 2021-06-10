part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();
}

class AuthBlocInitial extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthSuccesfull extends AuthBlocState {
  final bool isEmailSignIn;

  AuthSuccesfull(this.isEmailSignIn);
  @override
  List<Object> get props => [isEmailSignIn];
}

class AuthFailed extends AuthBlocState {
  final String message;

  AuthFailed(this.message);
  @override
  List<Object> get props => [message];
}
