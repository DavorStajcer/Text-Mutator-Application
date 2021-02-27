import 'package:text_mutator/data/models/words/clean_word.dart';

class Text {
  final List<CleanWord> text;
  final String name;

  const Text({this.text = const [], this.name = "some text"});
}
