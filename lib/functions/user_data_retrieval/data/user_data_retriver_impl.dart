import '../../../core/error/exceptions/exceptions.dart';
import '../../../core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../core/network/connection_checker.dart';
import 'datasources/user_local_datasource.dart';
import 'datasources/user_web_datasource.dart';
import '../domain/models/app_user.dart';
import '../domain/user_data_retriever.dart';

class UserDataRetriverImpl extends UserDataRetriver {
  final UserWebDataSource _userWebDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final ConnectionChecker _connectionChecker;

  UserDataRetriverImpl(
    this._userWebDataSource,
    this._connectionChecker,
    this._userLocalDataSource,
  );

  @override
  Future<Either<Failure, AppUser>> getUserData() async {
    try {
      if (!await _connectionChecker.hasConnection)
        return Left(NoConnetionFailure());
      String? _username = await _userLocalDataSource.getUsername();
      if (_username != null) return Right(AppUser(_username));
      _username = await _userWebDataSource.getUsername();
      if (_username != null) return Right(AppUser(_username));
      return Left(UserDataRetrievalFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserData(AppUser appUser) async {
    try {
      if (!await _connectionChecker.hasConnection)
        return Left(NoConnetionFailure());

      await _userWebDataSource.saveUsername(appUser.username);
      await _userLocalDataSource.saveUsername(appUser.username);
      return Right(null);
    } on LocalStorageException catch (_) {
      return Left(UserDataRetrievalFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
