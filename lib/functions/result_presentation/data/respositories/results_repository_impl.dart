import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/result_presentation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';
import 'package:text_mutator/functions/result_presentation/domain/repositories/result_respository.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';

class ResultRepositoryImpl extends ResultRepository {
  //final DatabaseSource _databaseSource;
  final NetworkResultDataSource _networkResultDataSource;
  final ConnectionChecker _connectionChecker;
  ResultRepositoryImpl(this._connectionChecker, this._networkResultDataSource);

  bool _isLastCashed = false;
  List<ResultModel> _cashedResults = [];

  Future<Result> calculateResult(MutatedText mutatedText) {
    return Future(() {
      int _wrongWords = 0;
      int _numberOfMarkedWords = 0;

      mutatedText.cleanWords.forEach((CleanWord currentWord) {
        if (currentWord.isSelected) {
          _wrongWords++;
          _numberOfMarkedWords++;
        }
      });

      mutatedText.mutatedWords.forEach((MutatedWord? currentWord) {
        if (currentWord!.isSelected) _numberOfMarkedWords++;
      });

      return ResultModel(
          mutatedText.mutatedWords.length,
          _wrongWords,
          _numberOfMarkedWords,
          mutatedText.resultDifficulty,
          DateTime.now().toIso8601String());
    });
  }

  @override
  Future<Either<Failure, List<Result>>> loadResults() async {
    if (await _connectionChecker.hasConnection) {
      try {
        if (_isLastCashed) return Right(_cashedResults);
        final List<Map<String, dynamic>> _res =
            await _networkResultDataSource.fetchResults();

        final List<ResultModel> _results = _res
            .map((Map<String, dynamic> map) => ResultModel.fromJson(map))
            .toList();
        _cashedResults = _results;
        _isLastCashed = true;
        return Right(_results);
      } catch (err) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnetionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveResult(ResultModel result) async {
    if (await _connectionChecker.hasConnection) {
      try {
        await _networkResultDataSource.saveResult(result);
        _cashedResults.add(result);
        return Right(null);
      } catch (err) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnetionFailure());
    }
  }
}
