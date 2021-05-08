import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:text_mutator/functions/authenticating_user/domain/contracts/user_authenticator.dart';

const String ERROR_AUTH_USER_NOT_FOUND = 'No user found for that email.';
const String ERROR_AUTH_WRONG_PASS = 'Wrong password provided for that user.';
const String ERROR_AUTH_INVALID_EMAIL = 'Email that you provided is invalid.';
const String ERROR_AUTH_WEAK_PASSWORD = 'Password is too weak.';
const String ERROR_AUTH_USER_DISABLED =
    'User corresponding to the given email has been disabled.';
const String ERROR_AUTH_UNKNOWN = 'Uknown error occured.';

class UserAuthenticatorImpl extends UserAuthenticator {
  final FirebaseAuth _firebaseAuth;

  UserAuthenticatorImpl(this._firebaseAuth);

  @override
  Future<Either<Failure, User>> authenticateUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user == null)
        throw FirebaseAuthException(code: 'user-not-found');
      return Right(_userCredential.user!);
    } on FirebaseAuthException catch (err) {
      return Left(UserAuthenticationFailure(_pickFailureMessage(err.code)));
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  String _pickFailureMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return ERROR_AUTH_USER_NOT_FOUND;
      case 'wrong-password':
        return ERROR_AUTH_WRONG_PASS;
      case 'invalid-email':
        return ERROR_AUTH_INVALID_EMAIL;
      case 'user-disabled':
        return ERROR_AUTH_USER_DISABLED;
      case 'weak-password':
        return ERROR_AUTH_WEAK_PASSWORD;
      default:
        return ERROR_AUTH_UNKNOWN;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
