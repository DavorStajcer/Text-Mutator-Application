part of 'results_graph_bloc.dart';

abstract class ResultsGraphState extends Equatable {
  const ResultsGraphState();
}

class ResultsGraphLoading extends ResultsGraphState {
  @override
  List<Object> get props => [];
}

class ResultsGraphLoaded extends ResultsGraphState {
  final List<Result> results;

  ResultsGraphLoaded(this.results);
  @override
  List<Object> get props => [results];
}

class ResultsGraphError extends ResultsGraphState {
  final String message;

  ResultsGraphError(this.message);
  @override
  List<Object> get props => [message];
}
