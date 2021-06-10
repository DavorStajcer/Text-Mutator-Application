import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants/error_messages.dart';
import '../../../../../core/error/failures/failure.dart';
import '../../../domain/models/result.dart';
import '../../../domain/repositories/result_respository.dart';

part 'results_graph_event.dart';
part 'results_graph_state.dart';

class ResultsGraphBloc extends Bloc<ResultsGraphEvent, ResultsGraphState> {
  final ResultRepository _resultRepository;
  ResultsGraphBloc(this._resultRepository) : super(ResultsGraphLoading());

  @override
  Stream<ResultsGraphState> mapEventToState(
    ResultsGraphEvent event,
  ) async* {
    if (event is LoadResults) {
      yield ResultsGraphLoading();
      final _either = await _resultRepository.loadResults();
      yield _either.fold(
        (Failure failure) => ResultsGraphError(_errorMessage(failure)),
        (List<Result> results) => ResultsGraphLoaded(results),
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
