import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/error_messages.dart';
import '../../../core/error/failures/failure.dart';
import '../../../core/network/connection_checker.dart';
import '../domain/contracts/user_authenticator.dart';

class UserAuthenticatorImpl extends UserAuthenticator {
  final FirebaseAuth _firebaseAuth;
  final ConnectionChecker _connectionChecker;
  final GoogleSignIn _googleSignIn;

  UserAuthenticatorImpl(
    this._firebaseAuth,
    this._connectionChecker,
    this._googleSignIn,
  );

  @override
  Future<Either<Failure, void>> authenticateUserWithEmailAndPassword(
      String email, String password) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(NoConnetionFailure());
    }
    try {
      final UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }
      return Right(null);
    } on FirebaseAuthException catch (err) {
      return Left(UserAuthenticationFailure(_pickFailureMessage(err.code)));
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> authenticateUserWithGoogle() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(NoConnetionFailure());
    }
    try {
      final _acc = await _googleSignIn.signIn();
      return Right(_acc == null);
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
      case 'email-already-in-use':
        return ERROR_AUTH_EMAIL_IN_USE;
      case 'wrong-password':
        return ERROR_AUTH_WRONG_PASS;
      case 'invalid-email':
        return ERROR_AUTH_INVALID_EMAIL;
      case 'user-disabled':
        return ERROR_AUTH_USER_DISABLED;
      case 'weak-password':
        return ERROR_AUTH_WEAK_PASSWORD;
      case 'operation-not-allowed':
        return ERROR_AUTH_WRONG_PASS;
      default:
        return ERROR_AUTH_UNKNOWN;
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(NoConnetionFailure());
    }
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.signOut();
      } else {
        await _googleSignIn.disconnect();
      }
      return Right(null);
    } catch (err) {
      log(err.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signUp(String email, String password) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      log('SIGNING UP');
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      log('SIGNED UP');
      return Right(null);
    } on FirebaseAuthException catch (err) {
      return Left(UserAuthenticationFailure(_pickFailureMessage(err.code)));
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
