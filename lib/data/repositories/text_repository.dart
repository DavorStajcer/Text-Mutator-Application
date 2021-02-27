import 'package:text_mutator/data/models/text.dart';
import 'package:text_mutator/data/models/words/clean_word.dart';

class TextRepository {
  Text _text;

  TextRepository();

  Future<void> parseText(String text) {
    return Future(() {
      List<CleanWord> _words = [];

      List<String> _verginWords = text.split(' ');
      print("WORDS:");
      print(_verginWords.toString());

      for (int index = 0; index < _verginWords.length; index++) {
        _words.add(CleanWord(
          word: _verginWords.elementAt(index),
          index: index,
        ));
      }

      _text = Text(text: _words);
    });
  }

  void setText(Text text) => _text;
  Text get text => _text;
}
