import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart' show visibleForTesting;
import '../../../text_load/domain/models/text.dart';

class TextEvaluationModel extends Equatable {
  final Text text;
  final int numberOfMutations;
  final bool includeConjuctions;
  late final double resultDifficulty;
  late final int maxNumberOfMutations;

  TextEvaluationModel(
    this.text,
    this.numberOfMutations,
    this.includeConjuctions,
  ) {
    final int _maxNumberOfMutations = _calculateMaxNumberOfMutations(text.text);
    this.maxNumberOfMutations = _maxNumberOfMutations;
    this.resultDifficulty = calculateResultDifficulty(_maxNumberOfMutations);
  }

  TextEvaluationModel copyWith({
    Text? text,
    int? numberOfMutations,
    bool? includeConjuctions,
    bool? includeSyncategorematic,
  }) {
    return TextEvaluationModel(
      text ?? this.text,
      numberOfMutations ?? this.numberOfMutations,
      includeConjuctions ?? this.includeConjuctions,
    );
  }

  int _calculateMaxNumberOfMutations(String text) {
    final List<String> _words = text.split(' ');
    return max(8, _words.length ~/ 10);
  }

  @visibleForTesting
  double calculateResultDifficulty(int maxNumberOfMutations) {
    return (text.textDifficulty.index * 25) + // max 50 percent difficulty
            ((numberOfMutations / (maxNumberOfMutations)) *
                35) + //35 percent depending on number of mutations
            (15 * (includeConjuctions ? 1 : 0)) //15 pecent for conunctions
        ;
  }

  @override
  List<Object?> get props => [
        text,
        numberOfMutations,
        includeConjuctions,
        resultDifficulty,
      ];
}
