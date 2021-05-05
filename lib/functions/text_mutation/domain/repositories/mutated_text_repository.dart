import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

abstract class MutatedTextRepository {
  Future<Either<Failure, void>> mutateText(
      String textToMutate, int numberOfMutations);
  void updateWord(Word word);
}
