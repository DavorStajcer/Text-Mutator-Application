import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_load/domain/repsositories/text_repository.dart';
part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  final TextRepository _textRepository;
  TextBloc(this._textRepository) : super(TextInitial()) {}

  @override
  Stream<TextState> mapEventToState(
    TextEvent event,
  ) async* {
    if (event is LoadText) {
      yield TextLoading();

      final _either = await _textRepository.loadText(event.textDifficulty);
      yield _either.fold(
        (Failure failure) => TextError(_errorMessage(failure)),
        (Text text) => TextLoaded(text),
      );
    } else if (event is SaveText) {
      yield TextLoading();

      final _either = await _textRepository
          .saveText(TextModel(event.text.text, '', event.text.textDifficulty));
      yield _either.fold(
        (Failure failure) => TextError(_errorMessage(failure)),
        (_) => TextInitial(),
      );
    }
  }

  String _errorMessage(Failure failure) {
    if (failure is NoConnetionFailure)
      return ERROR_NO_CONNECTION;
    else if (failure is AllTextsReadFailure)
      return ERROR_TEXT_LOAD_ALL_TEXT_READ;
    else
      return ERROR_SERVER_FAILURE;
  }
}
