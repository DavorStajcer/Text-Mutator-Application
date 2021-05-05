part of 'mutate_bloc.dart';

@immutable
abstract class MutateState {
  final MutatedText mutatedText;

  MutateState(this.mutatedText);
}

class MutateInitial extends MutateState {
  MutateInitial() : super(null);
}

class MutateLoading extends MutateState {
  MutateLoading(MutatedText mutatedText) : super(mutatedText);
}

class MutateLoaded extends MutateState {
  MutateLoaded(MutatedText mutatedText) : super(mutatedText);
}
