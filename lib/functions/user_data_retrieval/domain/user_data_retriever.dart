import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';

import 'models/app_user.dart';

abstract class UserDataRetriver {
  Future<Either<Failure, AppUser>> getUserData();
  Future<Either<Failure, void>> saveUserData(AppUser appUser);
}
