import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';

abstract class ResultRepository {
  Future<Result> calculateResult(MutatedText mutatedText);
  Future<Either<Failure, void>> saveResult(ResultModel result);
  Future<Either<Failure, List<Result>>> loadResults();
}
