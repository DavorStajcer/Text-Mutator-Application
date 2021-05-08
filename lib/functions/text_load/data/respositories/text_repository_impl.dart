import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/error/exceptions/exceptions.dart';
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
  Future<Either<Failure, Text>> loadText(
      TextDifficulty difficulty, List<String> solvedIds) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      final String _textDifficulty = _assignDifficulty(difficulty);

      final Map<String, dynamic> _text =
          await _networkTextDataSource.fetchText(_textDifficulty, solvedIds);
      final TextModel _textModel = TextModel.fromJson(_text);

      return Right(_textModel);
    } on AllTextsSolvedException {
      return Left(AllTextsReadFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  String _assignDifficulty(TextDifficulty difficulty) {
    switch (difficulty) {
      case TextDifficulty.Easy:
        return 'easy';
      case TextDifficulty.Medium:
        return 'medium';
      case TextDifficulty.Hard:
        return 'hard';

      default:
        return 'easy';
    }
  }

  @override
  Future<Either<Failure, void>> saveText(TextModel text) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      return Right(await _networkTextDataSource.saveText(
          text, _assignDifficulty(text.textDifficulty)));
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<String>>> getSolvedTextIds() async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      final List<String> _res =
          await _networkTextDataSource.fetchSolvedTextIds();

      return Right(_res);
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addSolvedTextId(String id) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      return Right(await _networkTextDataSource.saveSolvedText(id));
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
