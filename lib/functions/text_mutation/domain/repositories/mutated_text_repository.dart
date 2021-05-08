import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

abstract class MutatedTextRepository {
  Future<Either<Failure, MutatedText>> mutateText(
      TextEvaluationModel textEvaluationModel);

  Future<Either<Failure, void>> saveSolvedText(
      TextEvaluationModel textEvaluationModel);
  void updateWord(Word word);
}
