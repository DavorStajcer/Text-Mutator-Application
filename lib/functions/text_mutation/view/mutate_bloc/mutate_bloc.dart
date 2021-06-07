import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants/error_messages.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../text_evaluation/domain/model/text_evalluation_model.dart';
import '../../../text_load/data/enteties/text_model.dart';
import '../../../text_load/domain/repsositories/text_repository.dart';
import '../../domain/models/mutated_text.dart';
import '../../domain/models/word/word.dart';
import '../../domain/repositories/mutated_text_repository.dart';

part 'mutate_event.dart';
part 'mutate_state.dart';

class MutateBloc extends Bloc<MutateEvent, MutateState> {
  final MutatedTextRepository _mutatedTextRepository;
  final TextRepository _textRepository;

  MutateBloc(this._mutatedTextRepository, this._textRepository)
      : super(MutateInitial());

  @override
  Stream<MutateState> mapEventToState(
    MutateEvent event,
  ) async* {
    yield MutateLoading();
    if (event is MutateText) {
      final _either =
          await _mutatedTextRepository.mutateText(event.textEvaluationModel);

      final MutateState _result = _either.fold(
        (Failure failure) => MutateError(_errorMessage(failure)),
        (MutatedText mutatedText) => MutateLoaded(mutateText: mutatedText),
      );

      if (_result is MutateLoaded) {
        final _textSaveEither = await _textRepository.saveText(TextModel(
            event.textEvaluationModel.text.text,
            '',
            event.textEvaluationModel.text.textDifficulty));

        yield _textSaveEither.fold(
          (failure) => MutateError(_errorMessage(failure)),
          (r) => _result,
        );
      } else {
        yield _result;
      }
    } else if (event is UpdateWord) {
      _mutatedTextRepository.updateWord(event.word);
      yield MutateLoaded(mutateText: _mutatedTextRepository.mutatedText);
    }
  }

  String _errorMessage(Failure failure) {
    if (failure is NoConnetionFailure)
      return ERROR_NO_CONNECTION;
    else
      return ERROR_SERVER_FAILURE;
  }
}
