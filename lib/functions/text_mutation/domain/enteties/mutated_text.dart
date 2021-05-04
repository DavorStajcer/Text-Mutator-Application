import 'package:text_mutator/functions/text_mutation/domain/enteties/word/mutated_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/enteties/text.dart';

class MutatedText {
  final Text text;
  final List<MutatedWord> mutatedWords;
//HEJ DODO SAM NEKE PROMJENE TU SADA JA
  const MutatedText(this.text, this.mutatedWords);
}
