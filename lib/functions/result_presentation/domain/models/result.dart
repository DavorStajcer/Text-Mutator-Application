import 'dart:math';

import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final int numberOfMutatedWords;
  final int numberOfWrongWords;
  final int numberOfMarkedWords;
  final String id;
  final double difficulty;
  late final DateTime date;
  late final double score;

  Result({
    required this.numberOfMutatedWords,
    required this.numberOfWrongWords,
    required this.numberOfMarkedWords,
    required this.difficulty,
    required this.id,
    DateTime? dateOfResult,
  }) {
    this.date = dateOfResult ?? DateTime.now();

    int _numberOfWrongWords = numberOfWrongWords;
    final int _numberOfMutatedWords = numberOfMutatedWords;
    double _tempScore = 0;

    if (numberOfMarkedWords < _numberOfMutatedWords) {
      _numberOfWrongWords += _numberOfMutatedWords - numberOfMarkedWords;
    }

    _tempScore = _numberOfWrongWords / _numberOfMutatedWords;
    _tempScore = (1 - _tempScore) * 100;
    _tempScore = max(_tempScore, 0);
    score = _tempScore;
  }

  @override
  List<Object?> get props => [
        id,
        score,
        numberOfMutatedWords,
        numberOfWrongWords,
        numberOfMarkedWords,
        date
      ];
}
