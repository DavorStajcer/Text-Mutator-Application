import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';

part 'textevaluation_event.dart';
part 'textevaluation_state.dart';

class TextEvaluationBloc
    extends Bloc<TextEvaluationEvent, TextEvaluationState> {
  TextEvaluationBloc() : super(TextEvaluationInitial());

  @override
  Stream<TextEvaluationState> mapEventToState(
    TextEvaluationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
