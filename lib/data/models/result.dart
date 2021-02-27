import 'dart:math';

import 'text.dart';
import 'words/clean_word.dart';
import 'words/mutated_word.dart';

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
      _numberOfWrongWords +=
          (_numberOfMutatedWords - numberOfMarkedWords).abs();
    }

    score = _numberOfWrongWords / _numberOfMutatedWords;
    score = (1 - score) * 100;
    score = max(score, 0);
  }
}
