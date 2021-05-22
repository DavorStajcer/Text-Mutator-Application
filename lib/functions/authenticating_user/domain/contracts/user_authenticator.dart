import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures/failure.dart';

abstract class UserAuthenticator {
  Future<Either<Failure, void>> authenticateUserWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, void>> signUp(String email, String password);

  Future<Either<Failure, void>> signOut();
}
