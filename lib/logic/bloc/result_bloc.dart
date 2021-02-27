import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/core/selectable_text_widget.dart';
import 'package:text_mutator/data/models/result.dart';
import 'package:text_mutator/data/models/text.dart';
import 'package:text_mutator/data/repositories/results_repository.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final ResultRepository _resultRepository;
  ResultBloc(this._resultRepository) : super(ResultInitial());

  @override
  Stream<ResultState> mapEventToState(
    ResultEvent event,
  ) async* {
    if (event is CreateResult) {
      yield ResultLoading();
      await _resultRepository.calculateResult(event.allText, event.text);
      yield ResultLoaded(_resultRepository.result);
    } else if (event is Restart) {
      yield ResultInitial();
    } else if (event is AbandoneResult) {
      yield ResultAbandoned();
    }
  }
}
