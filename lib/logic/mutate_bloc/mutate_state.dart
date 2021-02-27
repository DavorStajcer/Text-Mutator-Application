part of 'mutate_bloc.dart';

@immutable
abstract class MutateState {}

class MutateInitial extends MutateState {
  MutateInitial();
}

class MutateLoading extends MutateState {}

class MutateLoaded extends MutateState {
  final MutatedText mutatedText;
  MutateLoaded(this.mutatedText);
}
