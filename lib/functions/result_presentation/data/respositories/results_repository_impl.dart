import 'package:dartz/dartz.dart';
import 'package:text_mutator/functions/database/database_source.dart';
import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/result_presentation/domain/repositories/result_respository.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';

class ResultRepositoryImpl extends ResultRepository {
  final DatabaseSource _databaseSource;

  ResultRepositoryImpl(this._databaseSource);

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

      mutatedText.mutatedWords.forEach((MutatedWord currentWord) {
        if (currentWord.isSelected) _numberOfMarkedWords++;
      });

      return ResultModel(mutatedText.mutatedWords.length, _wrongWords,
          _numberOfMarkedWords, 'test');
    });
  }

  @override
  Future<Either<Failure, List<Result>>> loadResults() async {
    final List<Map<String, dynamic>> _res =
        await _databaseSource.fetchResults();

    final List<ResultModel> _results = _res
        .map((Map<String, dynamic> map) => ResultModel.fromJson(map))
        .toList();
    return Right(_results);
  }

  @override
  Future<Either<Failure, void>> saveResult(ResultModel result) {
    // TODO: implement saveResult
    throw UnimplementedError();
  }
}
