import 'dart:math';

import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final int mutatedWords;
  final int wrongWords;
  final int numberOfMarkedWords;
  final String id;
  double score;

  Result({
    this.mutatedWords,
    this.wrongWords,
    this.numberOfMarkedWords,
    this.id,
  }) {
    int _numberOfWrongWords = wrongWords;
    final int _numberOfMutatedWords = mutatedWords;

    if (numberOfMarkedWords < _numberOfMutatedWords) {
      _numberOfWrongWords += _numberOfMutatedWords - numberOfMarkedWords;
    }

    score = _numberOfWrongWords / _numberOfMutatedWords;
    score = (1 - score) * 100;
    score = max(score, 0);
  }

  @override
  List<Object> get props => [id, mutatedWords, wrongWords, numberOfMarkedWords];
}
