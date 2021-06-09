part of 'results_difficulty_representation_cubit.dart';

abstract class ResultsDifficultyRepresentationState extends Equatable {
  final List<Result> resultsToShow;
  const ResultsDifficultyRepresentationState(this.resultsToShow);

  @override
  List<Object> get props => [resultsToShow];
}

class ResultsDifficultyRepresentationEasy
    extends ResultsDifficultyRepresentationState {
  ResultsDifficultyRepresentationEasy(List<Result> resultsToShow)
      : super(resultsToShow);
}

class ResultsDifficultyRepresentationMedium
    extends ResultsDifficultyRepresentationState {
  ResultsDifficultyRepresentationMedium(List<Result> resultsToShow)
      : super(resultsToShow);
}

class ResultsDifficultyRepresentationHard
    extends ResultsDifficultyRepresentationState {
  ResultsDifficultyRepresentationHard(List<Result> resultsToShow)
      : super(resultsToShow);
}

class ResultsDifficultyRepresentationImpossible
    extends ResultsDifficultyRepresentationState {
  ResultsDifficultyRepresentationImpossible(List<Result> resultsToShow)
      : super(resultsToShow);
}
