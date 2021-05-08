import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_mutator/core/error/failures/failure.dart';

abstract class UserAuthenticator {
  Future<Either<Failure, User>> authenticateUserWithEmailAndPassword(
      String email, String password);

  Future<void> signOut();
}
