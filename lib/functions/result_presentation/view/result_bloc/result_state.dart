part of 'result_bloc.dart';

@immutable
abstract class ResultState extends Equatable {
  const ResultState();
}

class ResultInitial extends ResultState {
  @override
  List<Object?> get props => [];
}

class ResultLoading extends ResultState {
  @override
  List<Object?> get props => [];
}

class ResultLoaded extends ResultState {
  final Result result;
  const ResultLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class ResultsLoaded extends ResultState {
  final List<Result> results;

  const ResultsLoaded(this.results);
  @override
  List<Object?> get props => [results];
}

class ResultError extends ResultState {
  final String message;

  ResultError(this.message);
  @override
  List<Object?> get props => [message];
}
