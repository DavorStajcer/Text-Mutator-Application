part of 'textevaluation_bloc.dart';

abstract class TextEvaluationEvent extends Equatable {
  const TextEvaluationEvent();
}

class TextEvaluationStarted extends TextEvaluationEvent {
  final Text text;
  TextEvaluationStarted(this.text);

  @override
  List<Object?> get props => [];
}

class TextMutationsChanged extends TextEvaluationEvent {
  final int numberOfMutations;

  TextMutationsChanged(this.numberOfMutations);

  @override
  List<Object> get props => [numberOfMutations];
}

class TextConjuctionsChanged extends TextEvaluationEvent {
  @override
  List<Object?> get props => [];
}

class TextSyncategorematicChanged extends TextEvaluationEvent {
  @override
  List<Object?> get props => [];
}
