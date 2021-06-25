import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_checker_event.dart';
part 'authentication_checker_state.dart';

class AuthenticationCheckerBloc
    extends Bloc<AuthenticationCheckerEvent, AuthenticationCheckerState> {
  final GoogleSignIn _googleSignIn;

  AuthenticationCheckerBloc(FirebaseAuth firebaseAuth, this._googleSignIn)
      : super(AuthenticationCheckerInitial()) {
    // firebaseAuth.signOut();

    // if (firebaseAuth.currentUser != null)
    //   this.add(AuthenticationStateChanged(true));

    firebaseAuth.userChanges().listen(
      (User? user) {
        log('user changed: ' + user.toString());
        if (user == null) {
          this.add(AuthenticationStateChanged(false));
        } else {
          this.add(AuthenticationStateChanged(true));
        }
      },
      onError: (_) {
        this.add(AuthenticationStateChanged(false));
      },
    );

    _googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) {
        log('google sign in changed');
        if (account != null) {
          this.add(AuthenticationStateChanged(true));
        }
      },
      onError: (_) {
        this.add(AuthenticationStateChanged(false));
      },
    );
    _googleSignIn.signInSilently();
  }

  @override
  Stream<AuthenticationCheckerState> mapEventToState(
    AuthenticationCheckerEvent event,
  ) async* {
    log(event.toString());
    if (event is AuthenticationStateChanged)
      yield event.isLogedIn ? UserAuthenticated() : UserNotAuthenticated();
  }
}
