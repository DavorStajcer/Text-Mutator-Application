import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../text_mutation/domain/models/mutated_text.dart';
import '../models/result.dart';

abstract class ResultRepository {
  Future<Result> calculateResult(MutatedText mutatedText);
  Future<Either<Failure, Result>> saveResult(MutatedText mutatedText);
  Future<Either<Failure, List<Result>>> loadResults();
}
