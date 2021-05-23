import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';

abstract class UserDataRepository {
  Future<Either<Failure, AppUser>> getUserData();
  Future<Either<Failure, void>> saveUserData(AppUser appUser);
}
