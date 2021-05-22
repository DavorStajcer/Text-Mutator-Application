import 'package:equatable/equatable.dart';
import 'word/clean_word.dart';
import 'word/mutated_word.dart';

class MutatedText extends Equatable {
  final List<CleanWord> cleanWords;
  final List<MutatedWord> mutatedWords;
  final double resultDifficulty;

  const MutatedText(
    this.cleanWords,
    this.mutatedWords,
    this.resultDifficulty,
  );

  @override
  List<Object?> get props => [...cleanWords, ...mutatedWords, resultDifficulty];
}
