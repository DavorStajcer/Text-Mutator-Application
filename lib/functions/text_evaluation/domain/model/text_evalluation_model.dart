import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart' show visibleForTesting;
import 'package:text_mutator/functions/text_load/domain/models/text.dart';

/*
Words like 'the', 'a', and 'of' are often called syncategorematic words, words "that do not stand by themselves... (i.e. prepositions, logical connectives, etc.)" (here).

Examples of syncategorematic terms include:

articles (for example, 'the' and 'a')
connectives (for example, 'and' and 'or')
prepositions (for exmaple, 'in' and 'at')
quantifiers (for example, 'some' and 'all')
 */

class TextEvaluationModel extends Equatable {
  final Text text;
  final int numberOfMutations;
  final bool includeConjuctions;
  final bool includeSyncategorematic;
  late final double resultDifficulty;

  TextEvaluationModel(
    this.text,
    this.numberOfMutations,
    this.includeConjuctions,
    this.includeSyncategorematic,
  ) {
    this.resultDifficulty = calculateResultDifficulty();
  }

  // @visibleForTesting
  // double get difficulty => this.resultDifficulty;

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
      includeSyncategorematic ?? this.includeSyncategorematic,
    );
  }

  @visibleForTesting
  double calculateResultDifficulty() {
    return (text.textDifficulty.index * 25) + // max 55 percent difficulty
        ((numberOfMutations / (text.text.split(' ').length / 4)) *
            25) + //25 percent depending on number of mutations
        (10 * (includeConjuctions ? 1 : 0)) + //10 pecent for conunctions
        (10 *
            (includeSyncategorematic
                ? 1
                : 0)); //10 percent for a, the, of, and...
  }

  @override
  List<Object?> get props => [
        text,
        numberOfMutations,
        includeConjuctions,
        includeSyncategorematic,
        resultDifficulty,
      ];
}
