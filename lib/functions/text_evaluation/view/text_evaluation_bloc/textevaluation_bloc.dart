import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_mutator/core/constants/enums.dart';
import '../../domain/model/text_evalluation_model.dart';
import '../../../text_load/domain/models/text.dart';

part 'textevaluation_event.dart';
part 'textevaluation_state.dart';

class TextEvaluationBloc
    extends Bloc<TextEvaluationEvent, TextEvaluationState> {
  TextEvaluationBloc() : super(TextEvaluationInitial());

  @override
  Stream<TextEvaluationState> mapEventToState(
    TextEvaluationEvent event,
  ) async* {
    if (event is TextEvaluationStarted) {
      yield TextEvaluationLoaded(TextEvaluationModel(event.text, 4, false));
    } else if (event is TextMutationsChanged) {
      yield TextEvaluationLoaded(state.textEvaluationModel
          .copyWith(numberOfMutations: event.numberOfMutations));
    } else if (event is TextConjuctionsChanged) {
      yield TextEvaluationLoaded(
          state.textEvaluationModel.copyWith(includeConjuctions: event.value));
    }
  }
}
