import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';

abstract class UserDataRetriver {
  Future<Either<Failure, String>> getUsername();
}
