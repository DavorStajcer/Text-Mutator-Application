import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignedUserProvider {
  String? getCurrentUserUsername();
  String getCurrentUserId();
}

class SignedUserProviderImpl extends SignedUserProvider {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  SignedUserProviderImpl(this._firebaseAuth, this._googleSignIn);

  String? getCurrentUserUsername() {
    String? _userDisplayName = _firebaseAuth.currentUser?.displayName;
    log('firebase auth' + _userDisplayName.toString());
    _userDisplayName = _googleSignIn.currentUser?.displayName;
    log('google sign in:' + _userDisplayName.toString());
    return _userDisplayName;
  }

  String getCurrentUserId() {
    String _userId = '';
    if (_firebaseAuth.currentUser != null) {
      _userId = _firebaseAuth.currentUser!.uid;
    } else if (_googleSignIn.currentUser != null) {
      _userId = _googleSignIn.currentUser!.id;
    }
    return _userId;
  }
}
