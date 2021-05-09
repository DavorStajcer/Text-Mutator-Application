part of 'mutate_bloc.dart';

@immutable
abstract class MutateState extends Equatable {
  MutateState();
}

class MutateInitial extends MutateState {
  MutateInitial() : super();

  @override
  List<Object?> get props => [];
}

class MutateLoading extends MutateState {
  MutateLoading() : super();

  @override
  List<Object?> get props => [];
}

class MutateLoaded extends MutateState {
  final MutatedText mutateText;

  MutateLoaded({required this.mutateText}) : super();
  @override
  List<Object?> get props => [mutateText];
}

class MutateError extends MutateState {
  final String message;

  MutateError(this.message);
  @override
  List<Object?> get props => [message];
}
