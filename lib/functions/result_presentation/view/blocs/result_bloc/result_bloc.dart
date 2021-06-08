import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants/error_messages.dart';
import '../../../../../core/error/failures/failure.dart';
import '../../../../text_mutation/domain/models/mutated_text.dart';
import '../../../domain/models/result.dart';
import '../../../domain/repositories/result_respository.dart';

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
      final _either = await _resultRepository.saveResult(event.mutatedText);
      yield _either.fold(
        (failure) => ResultError(_errorMessage(failure)),
        (Result result) => ResultLoaded(result),
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
