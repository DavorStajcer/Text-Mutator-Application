part of 'textevaluation_bloc.dart';

abstract class TextEvaluationState extends Equatable {
  const TextEvaluationState();
}

class TextEvaluationInitial extends TextEvaluationState {
  TextEvaluationInitial() : super();

  @override
  List<Object> get props => [];
}

class TextEvaluationLoaded extends TextEvaluationState {
  final TextEvaluationModel textEvaluationModel;

  TextEvaluationLoaded(this.textEvaluationModel) : super();
  @override
  List<Object> get props => [textEvaluationModel];
}
