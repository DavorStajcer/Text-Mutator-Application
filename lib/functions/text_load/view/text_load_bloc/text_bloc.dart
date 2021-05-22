import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/error_messages.dart';
import '../../../../core/error/failures/failure.dart';
import '../../data/enteties/text_model.dart';
import '../../domain/models/text.dart';
import '../../domain/repsositories/text_repository.dart';
import '../text_validation_bloc/textvalidator_bloc.dart';
part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  final TextRepository _textRepository;
  final TextValidatorBloc _textValidatorBloc;
  TextBloc(
    this._textRepository,
    this._textValidatorBloc,
  ) : super(TextInitial());

  @override
  Stream<TextState> mapEventToState(
    TextEvent event,
  ) async* {
    if (event is LoadText) {
      yield TextLoading();

      final _either = await _textRepository.loadText(event.textDifficulty);
      yield _either.fold(
        (Failure failure) => TextError(_errorMessage(failure)),
        (Text text) {
          _textValidatorBloc.add(TextChanged(text.text));
          return TextLoaded(text);
        },
      );
    } else if (event is SaveText) {
      yield TextLoading();

      final _either = await _textRepository
          .saveText(TextModel(event.text.text, '', event.text.textDifficulty));
      yield _either.fold(
        (Failure failure) => TextError(_errorMessage(failure)),
        (_) => TextInitial(),
      );
    } else if (event is SetText) {
      yield TextLoaded(event.text);
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
