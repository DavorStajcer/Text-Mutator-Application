import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_source.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_retriever.dart';

class UserDataRetriverImpl extends UserDataRetriver {
  final UserDataSource _userDataSource;
  final ConnectionChecker _connectionChecker;

  UserDataRetriverImpl(this._userDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, String>> getUsername() async {
    try {
      if (!await _connectionChecker.hasConnection)
        return Left(NoConnetionFailure());
      final _username = await _userDataSource.getUsername();
      return Right(_username);
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
