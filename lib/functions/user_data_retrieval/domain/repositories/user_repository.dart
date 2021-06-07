import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../models/app_user.dart';

abstract class UserDataRepository {
  Future<Either<Failure, AppUser>> getUserData();
  Future<Either<Failure, void>> saveUserData(AppUser appUser);
}
