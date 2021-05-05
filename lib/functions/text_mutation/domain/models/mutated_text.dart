import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

class MutatedText {
  final List<CleanWord> cleanWords;
  final List<MutatedWord> mutatedWords;

  const MutatedText(
    this.cleanWords,
    this.mutatedWords,
  );
}
