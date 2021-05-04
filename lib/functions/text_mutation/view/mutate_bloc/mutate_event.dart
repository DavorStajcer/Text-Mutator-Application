part of 'mutate_bloc.dart';

@immutable
abstract class MutateEvent {
  const MutateEvent();
}

class MutateText extends MutateEvent {
  final Text text;
  final int numberOfMutations;
  const MutateText(this.text, this.numberOfMutations);
}
