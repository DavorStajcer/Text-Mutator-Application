part of 'textevaluation_bloc.dart';

abstract class TextEvaluationState extends Equatable {
  final TextEvaluationModel textEvaluationModel;
  const TextEvaluationState(this.textEvaluationModel);
  @override
  List<Object> get props => [textEvaluationModel];
}

class TextEvaluationInitial extends TextEvaluationState {
  TextEvaluationInitial()
      : super(TextEvaluationModel(
            Text(id: '', text: '', textDifficulty: TextDifficulty.Easy),
            1,
            false,
            false));

  @override
  List<Object> get props => [];
}

class TextEvaluationLoaded extends TextEvaluationState {
  TextEvaluationLoaded(TextEvaluationModel textEvaluationModel)
      : super(textEvaluationModel);
}
