import 'package:text_mutator/data/models/words/mutated_word.dart';
import 'package:text_mutator/data/models/text.dart';

class MutatedText {
  final Text text;
  final List<MutatedWord> mutatedWords;
//HEJ DODO SAM NEKE PROMJENE TU SADA JA
  const MutatedText(this.text, this.mutatedWords);
}
