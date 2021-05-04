import 'dart:math';

import 'text.dart';
import 'word/clean_word.dart';
import 'word/mutated_word.dart';

class Result {
  final Text text;
  final List<MutatedWord> mutatedWords;
  final List<CleanWord> wrongWords;
  final int numberOfMarkedWords;
  double score;

  Result({
    this.text,
    this.mutatedWords,
    this.wrongWords,
    this.numberOfMarkedWords,
  }) {
    int _numberOfWrongWords = wrongWords.length;
    final int _numberOfMutatedWords = mutatedWords.length;

    if (numberOfMarkedWords < _numberOfMutatedWords) {
      _numberOfWrongWords += _numberOfMutatedWords - numberOfMarkedWords;
    }

    score = _numberOfWrongWords / _numberOfMutatedWords;
    score = (1 - score) * 100;
    score = max(score, 0);
  }
}
