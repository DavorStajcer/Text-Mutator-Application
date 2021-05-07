import 'package:dartz/dartz.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';

abstract class TextRepository {
  Future<Either<Failure, Text>> loadText(String id);
  Future<Either<Failure, void>> saveText(TextModel id);
}
