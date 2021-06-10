import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/models/text.dart';
import '../../domain/repsositories/text_repository.dart';
import '../datasources/network_data_source.dart';
import '../enteties/text_model.dart';

class TextRepositoryImpl extends TextRepository {
  // final DatabaseSource _databaseSource;
  final ConnectionChecker _connectionChecker;
  final NetworkTextDataSource _networkTextDataSource;

  TextRepositoryImpl(this._connectionChecker, this._networkTextDataSource);

  @override
  Future<Either<Failure, Text>> loadText(TextDifficulty difficulty) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      final List<String> _solvedIds =
          await _networkTextDataSource.fetchSolvedTextIds();

      final String _textDifficulty = _assignDifficulty(difficulty);

      final Map<String, dynamic> _text =
          await _networkTextDataSource.fetchText(_textDifficulty, _solvedIds);

      final TextModel _textModel = TextModel.fromJson(_text);

      return Right(_textModel);
    } on AllTextsSolvedException {
      return Left(AllTextsReadFailure());
    } catch (err) {
      log(err.toString());
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
  Future<Either<Failure, void>> saveText(
    TextModel text,
  ) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      String _textId = text.id;

      if (_textId.length < 8) {
        _textId = await _networkTextDataSource.saveText(
            text, _assignDifficulty(text.textDifficulty));
      }

      await _networkTextDataSource.saveSolvedText(_textId);
      return Right(null);
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
