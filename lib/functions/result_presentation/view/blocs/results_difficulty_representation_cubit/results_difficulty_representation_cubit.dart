import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/result.dart';

part 'results_difficulty_representation_state.dart';

enum ResultsDifficultyRepresentation {
  Easy,
  Medium,
  Hard,
  Impossible,
}

class ResultsDifficultyRepresentationCubit
    extends Cubit<ResultsDifficultyRepresentationState> {
  ResultsDifficultyRepresentationCubit()
      : super(ResultsDifficultyRepresentationEasy([]));

  final List<Result> _graphSpostsEasy = [];
  final List<Result> _graphSpostsMedium = [];
  final List<Result> _graphSpostsHard = [];
  final List<Result> _graphSpostsImpossible = [];

  void initializeResults(List<Result> results) {
    _initializeDifficultyResultLists(
      results,
      _graphSpostsEasy,
      _graphSpostsMedium,
      _graphSpostsHard,
      _graphSpostsImpossible,
    );
    emit(ResultsDifficultyRepresentationEasy(_graphSpostsEasy));
  }

  void changeRepresentation(ResultsDifficultyRepresentation representation) {
    late final ResultsDifficultyRepresentationState _newState;
    switch (representation) {
      case ResultsDifficultyRepresentation.Easy:
        _newState = ResultsDifficultyRepresentationEasy(_graphSpostsEasy);
        break;
      case ResultsDifficultyRepresentation.Medium:
        _newState = ResultsDifficultyRepresentationMedium(_graphSpostsMedium);
        break;
      case ResultsDifficultyRepresentation.Hard:
        _newState = ResultsDifficultyRepresentationHard(_graphSpostsHard);
        break;
      case ResultsDifficultyRepresentation.Impossible:
        _newState =
            ResultsDifficultyRepresentationImpossible(_graphSpostsImpossible);
        break;
      default:
        _newState = ResultsDifficultyRepresentationEasy(_graphSpostsEasy);
    }
    emit(_newState);
  }

  void _initializeDifficultyResultLists(
      List<Result> results,
      List<Result> _graphSpostsEasy,
      List<Result> _graphSpostsMedium,
      List<Result> _graphSpostsHard,
      List<Result> _graphSpostsImpossible) {
    _graphSpostsEasy.clear();
    _graphSpostsMedium.clear();
    _graphSpostsHard.clear();
    _graphSpostsImpossible.clear();
    for (var i = 0; i < results.length; i++) {
      final Result _currentRes = results[i];
      if (_currentRes.difficulty < 61) {
        _graphSpostsEasy.add(results[i]);
      } else if (_currentRes.difficulty < 81) {
        _graphSpostsMedium.add(results[i]);
      } else if (_currentRes.difficulty < 96) {
        _graphSpostsHard.add(results[i]);
      } else {
        _graphSpostsImpossible.add(results[i]);
      }
    }
  }
}
