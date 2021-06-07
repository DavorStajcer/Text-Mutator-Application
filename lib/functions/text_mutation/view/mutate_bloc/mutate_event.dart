part of 'mutate_bloc.dart';

@immutable
abstract class MutateEvent extends Equatable {
  const MutateEvent();
}

class MutateText extends MutateEvent {
  final TextEvaluationModel textEvaluationModel;
  final bool shouldSave;

  const MutateText(
    this.textEvaluationModel,
    this.shouldSave,
  );

  @override
  List<Object?> get props => [textEvaluationModel];
}

class UpdateWord extends MutateEvent {
  final Word word;

  UpdateWord(this.word);

  @override
  List<Object?> get props => [word];
}
