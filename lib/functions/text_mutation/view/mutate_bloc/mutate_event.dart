part of 'mutate_bloc.dart';

@immutable
abstract class MutateEvent {
  const MutateEvent();
}

class MutateText extends MutateEvent {
  final String text;
  final int numberOfMutations;
  const MutateText(this.text, this.numberOfMutations);
}

class UpdateWord extends MutateEvent {
  final Word word;

  UpdateWord(this.word);
}
