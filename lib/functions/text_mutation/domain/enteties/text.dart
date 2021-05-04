import 'package:text_mutator/functions/text_mutation/domain/enteties/word/clean_word.dart';

class Text {
  final List<CleanWord> text;
  final String name;

  const Text({this.text = const [], this.name = "some text"});
}
