import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../text_evaluation/domain/model/text_evalluation_model.dart';
import '../models/mutated_text.dart';
import '../models/word/word.dart';

abstract class MutatedTextRepository {
  Future<Either<Failure, MutatedText>> mutateText(
      TextEvaluationModel textEvaluationModel);

  // Future<Either<Failure, void>> saveSolvedText(
  //     TextEvaluationModel textEvaluationModel);

  MutatedText get mutatedText;
  void updateWord(Word word);
}
