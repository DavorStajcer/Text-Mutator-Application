import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/constants/error_messages.dart';
import '../../../../core/error/failures/failure.dart';
import '../../domain/repositories/result_respository.dart';
import '../../../text_mutation/domain/models/mutated_text.dart';
import '../../domain/models/result.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final ResultRepository _resultRepository;
  ResultBloc(this._resultRepository)
      : super(ResultLoaded(Result(
          difficulty: 44,
          id: '',
          numberOfMarkedWords: 4,
          numberOfMutatedWords: 4,
          numberOfWrongWords: 1,
        )));

  @override
  Stream<ResultState> mapEventToState(
    ResultEvent event,
  ) async* {
    if (event is CreateResult) {
      yield ResultLoading();
      final _either = await _resultRepository.saveResult(event.mutatedText);
      yield _either.fold(
        (failure) => ResultError(_errorMessage(failure)),
        (Result result) => ResultLoaded(result),
      );
    } else if (event is LoadResults) {
      yield ResultLoading();
      final _either = await _resultRepository.loadResults();
      yield _either.fold(
        (failure) => ResultError(_errorMessage(failure)),
        (List<Result> results) => ResultsLoaded(results),
      );
    }
  }

  String _errorMessage(Failure failure) {
    if (failure is NoConnetionFailure)
      return ERROR_NO_CONNECTION;
    else
      return ERROR_SERVER_FAILURE;
  }
}
