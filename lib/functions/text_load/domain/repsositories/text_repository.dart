import 'package:dartz/dartz.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/error/failures/failure.dart';
import '../../data/enteties/text_model.dart';
import '../models/text.dart';

abstract class TextRepository {
  Future<Either<Failure, Text>> loadText(TextDifficulty difficulty);
  Future<Either<Failure, void>> saveText(TextModel textModel);
  // Future<Either<Failure, void>> addSolvedTextId(String id);
}
