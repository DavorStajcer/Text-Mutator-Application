import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_load/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_load/domain/repsositories/text_repository.dart';

class TextRepositoryImpl extends TextRepository {
  // final DatabaseSource _databaseSource;
  final ConnectionChecker _connectionChecker;
  final NetworkTextDataSource _networkTextDataSource;

  TextRepositoryImpl(this._connectionChecker, this._networkTextDataSource);

  @override
  Future<Either<Failure, Text>> loadText(String id) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      final Map<String, dynamic> _text =
          await _networkTextDataSource.fetchText(id);
      final TextModel _textModel = TextModel.fromJson(_text);

      return Right(_textModel);
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveText(TextModel text) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      return Right(await _networkTextDataSource.saveText(text));
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
