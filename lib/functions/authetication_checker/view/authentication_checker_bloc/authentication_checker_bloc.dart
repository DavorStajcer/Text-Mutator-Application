import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_checker_event.dart';
part 'authentication_checker_state.dart';

class AuthenticationCheckerBloc
    extends Bloc<AuthenticationCheckerEvent, AuthenticationCheckerState> {
  AuthenticationCheckerBloc(FirebaseAuth firebaseAuth)
      : super(AuthenticationCheckerInitial()) {
    if (firebaseAuth.currentUser != null)
      this.add(AuthenticationStateChanged(true));
    firebaseAuth.userChanges().listen(
      (User? user) {
        if (user == null)
          this.add(AuthenticationStateChanged(false));
        else
          AuthenticationStateChanged(true);
      },
      onError: (_) {
        this.add(AuthenticationStateChanged(false));
      },
    );
  }

  @override
  Stream<AuthenticationCheckerState> mapEventToState(
    AuthenticationCheckerEvent event,
  ) async* {
    if (event is AuthenticationStateChanged)
      yield event.isLogedIn ? UserAuthenticated() : UserNotAuthenticated();
  }
}
