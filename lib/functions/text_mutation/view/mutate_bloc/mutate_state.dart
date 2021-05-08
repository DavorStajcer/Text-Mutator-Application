part of 'mutate_bloc.dart';

@immutable
abstract class MutateState {
  MutateState();
}

class MutateInitial extends MutateState {
  MutateInitial() : super();
}

class MutateLoading extends MutateState {
  MutateLoading() : super();
}

class MutateLoaded extends MutateState {
  final MutateText mutateText;

  MutateLoaded({required this.mutateText}) : super();
}

class MutateAndSavingFinished extends MutateState {}
