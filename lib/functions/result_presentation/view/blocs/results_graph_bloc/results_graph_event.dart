part of 'results_graph_bloc.dart';

abstract class ResultsGraphEvent extends Equatable {
  const ResultsGraphEvent();

  @override
  List<Object> get props => [];
}

class LoadResults extends ResultsGraphEvent {}
