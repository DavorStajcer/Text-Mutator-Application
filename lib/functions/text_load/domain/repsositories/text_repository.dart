import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';

abstract class TextRepository {
  Future<Either<Failure, Text>> loadText(TextDifficulty difficulty);
  Future<Either<Failure, void>> saveText(TextModel textModel);
  // Future<Either<Failure, List<String>>> getSolvedTextIds();
  Future<Either<Failure, void>> addSolvedTextId(String id);
}
