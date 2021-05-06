import 'package:dartz/dartz.dart';
import 'package:text_mutator/functions/database/database_source.dart';
import 'package:text_mutator/functions/text_input_and_load/data/enteties/text_model.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_input_and_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_input_and_load/domain/repsositories/text_repository.dart';

class TextRepositoryImpl extends TextRepository {
  final DatabaseSource? _databaseSource;

  Text? _currentText;

  TextRepositoryImpl(this._databaseSource);

  @override
  Future<Either<Failure, Text>> loadText(String id) async {
    try {
      final Map<String, dynamic> _text = await _databaseSource!.fetchText(id);
      final TextModel _textModel = TextModel.fromJson(_text);

      return Right(_textModel);
    } catch (err) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveText(TextModel text) async {
    try {
      return Right(await _databaseSource!.saveText(text));
    } catch (err) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Text? get text => _currentText;
}
