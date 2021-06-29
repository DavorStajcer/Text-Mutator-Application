import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../../core/network/connection_checker.dart';
import '../../../text_mutation/domain/models/mutated_text.dart';
import '../../../text_mutation/domain/models/word/clean_word.dart';
import '../../../text_mutation/domain/models/word/mutated_word.dart';
import '../../domain/models/result.dart';
import '../../domain/repositories/result_respository.dart';
import '../datasources/network_data_source.dart';
import '../enteties/result_model.dart';

class ResultRepositoryImpl extends ResultRepository {
  //final DatabaseSource _databaseSource;
  final NetworkResultDataSource _networkResultDataSource;
  final ConnectionChecker _connectionChecker;
  ResultRepositoryImpl(this._connectionChecker, this._networkResultDataSource);

  @visibleForTesting
  Future<ResultModel> calculateResult(MutatedText mutatedText) {
    return Future(() {
      int _numberOfMarkedWords = 0;
      int _wrongWords = 0;

      mutatedText.cleanWords.forEach((CleanWord currentWord) {
        if (currentWord.isSelected) {
          _wrongWords++;
          _numberOfMarkedWords++;
        }
      });

      mutatedText.mutatedWords.forEach((MutatedWord? currentWord) {
        if (currentWord!.isSelected) _numberOfMarkedWords++;
      });

      final ResultModel _resultModel = ResultModel(
        mutatedText.mutatedWords.length,
        _wrongWords,
        _numberOfMarkedWords,
        mutatedText.resultDifficulty,
        '',
      );

      return _resultModel;
    });
  }

  @override
  Future<Either<Failure, List<Result>>> loadResults() async {
    if (await _connectionChecker.hasConnection) {
      try {
        return await _loadAllResultsForCurrentUser();
      } catch (err) {
        print('results loading error: ' + err.toString());
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnetionFailure());
    }
  }

  Future<Right<Failure, List<Result>>> _loadAllResultsForCurrentUser() async {
    final List<Map<String, dynamic>> _res =
        await _networkResultDataSource.fetchResults();

    print('results maps list is: ' + _res.toString());

    final List<ResultModel> _results = _res
        .map((Map<String, dynamic> map) => ResultModel.fromJson(map))
        .toList();

    return Right(_results..sort((a, b) => a.date.compareTo(b.date)));
  }

  @override
  Future<Either<Failure, Result>> saveResult(MutatedText mutatedText) async {
    if (await _connectionChecker.hasConnection) {
      try {
        final ResultModel _result = await calculateResult(mutatedText);

        await _networkResultDataSource.saveResult(_result);
        return Right(_result);
      } catch (err) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnetionFailure());
    }
  }
}
