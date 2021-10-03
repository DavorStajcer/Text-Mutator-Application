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
    // _googleSignIn.signOut();
    if (firebaseAuth.currentUser != null) {
      this.add(AuthenticationStateChanged(true));
    }
    _trySingingInSilently();
    _subscribeToUserAuthenitcationChangesForAllSignInOptions(firebaseAuth);
  }

  @override
  Stream<AuthenticationCheckerState> mapEventToState(
    AuthenticationCheckerEvent event,
  ) async* {
    log(event.toString());
    print(event.toString());
    if (event is AuthenticationStateChanged)
      yield event.isLogedIn ? UserAuthenticated() : UserNotAuthenticated();
  }
}

// Authenitcation checking functions
extension on AuthenticationCheckerBloc {
  void _trySingingInSilently() async {
    final account = await _googleSignIn.signInSilently();
    print("::::ACCOUNT OF GOOGLE IS  NULL! ...........");
    if (account != null) {
      print("::::ACCOUNT OF GOOGLE IS NOT NULL!");
      this.add(AuthenticationStateChanged(true));
    }
  }

  void _subscribeToUserAuthenitcationChangesForAllSignInOptions(
      FirebaseAuth firebaseAuth) {
    _googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) {
        print('google sign in changed:' + account.toString());
        if (account != null) {
          this.add(AuthenticationStateChanged(true));
        } else {
          this.add(AuthenticationStateChanged(false));
        }
      },
      onError: (_) {
        this.add(AuthenticationStateChanged(false));
      },
    );

    firebaseAuth.userChanges().listen(
      (User? user) {
        print('user changed: ' + user.toString());
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
  }
}
