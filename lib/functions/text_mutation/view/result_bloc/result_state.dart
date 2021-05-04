part of 'result_bloc.dart';

@immutable
abstract class ResultState {
  const ResultState();
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final Result result;
  const ResultLoaded(this.result);
}

class ResultAbandoned extends ResultState {}
