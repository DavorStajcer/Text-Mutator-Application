import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/functions/result_presentation/domain/repositories/result_respository.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';

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
      final res = await _resultRepository.calculateResult(event.mutatedText);
      yield ResultLoaded(res);
    } else if (event is Restart) {
      yield ResultInitial();
    } else if (event is AbandoneResult) {
      yield ResultAbandoned();
    }
  }
}
