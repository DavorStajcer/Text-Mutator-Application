import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/error_messages.dart';
import '../../../../core/error/failures/failure.dart';
import '../../domain/contracts/user_authenticator.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserAuthenticator _userAuthenticator;
  AuthBloc(this._userAuthenticator) : super(AuthBlocInitial());

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    yield AuthLoading();
    if (event is LogIn) {
      final either = await _userAuthenticator
          .authenticateUserWithEmailAndPassword(event.email, event.password);
      yield _yieldState(either);
    } else if (event is SignUp) {
      final either =
          await _userAuthenticator.signUp(event.email, event.password);
      yield _yieldState(either);
    } else if (event is SignOut) {
      final either = await _userAuthenticator.signOut();
      yield either.fold(
          (l) => AuthFailed(ERROR_NO_CONNECTION), (r) => AuthBlocInitial());
    }
  }

  AuthBlocState _yieldState(Either<Failure, void> either) {
    return either.fold(
      (failure) {
        if (failure is UserAuthenticationFailure) {
          return AuthFailed(failure.message);
        } else if (failure is NoConnetionFailure) {
          return AuthFailed(ERROR_NO_CONNECTION);
        }
        return AuthFailed('Failed to sign in user.');
      },
      (r) => AuthSuccesfull(),
    );
  }
}
