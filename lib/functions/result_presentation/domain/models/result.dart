import 'dart:math';

import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final int mutatedWords;
  final int wrongWords;
  final int numberOfMarkedWords;
  final String id;
  final double difficulty;
  late final double score;

  Result({
    required this.mutatedWords,
    required this.wrongWords,
    required this.numberOfMarkedWords,
    required this.difficulty,
    required this.id,
  }) {
    int _numberOfWrongWords = wrongWords;
    final int _numberOfMutatedWords = mutatedWords;
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
  List<Object?> get props =>
      [id, mutatedWords, wrongWords, numberOfMarkedWords, score];
}
