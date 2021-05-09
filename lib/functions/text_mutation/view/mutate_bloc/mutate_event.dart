part of 'mutate_bloc.dart';

@immutable
abstract class MutateEvent {
  const MutateEvent();
}

class MutateText extends MutateEvent {
  final TextEvaluationModel textEvaluationModel;

  const MutateText(
    this.textEvaluationModel,
  );
}

class UpdateWord extends MutateEvent {
  final Word word;

  UpdateWord(this.word);
}
