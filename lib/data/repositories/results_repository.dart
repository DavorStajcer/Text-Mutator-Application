import 'package:text_mutator/core/selectable_text_widget.dart';
import 'package:text_mutator/data/models/result.dart';
import 'package:text_mutator/data/models/text.dart';
import 'package:text_mutator/data/models/words/clean_word.dart';
import 'package:text_mutator/data/models/words/mutated_word.dart';

class ResultRepository {
  Result _result;

  Result get result => _result;

  Future<void> calculateResult(List<SelectableTextWidget> allText, Text text) {
    return Future(() {
      List<MutatedWord> _mutatedWords = [];
      List<CleanWord> _wrongWords = [];
      int _numberOfMarkedWords = 0;

      if (allText != null)
        allText.forEach((SelectableTextWidget currentWord) {
          if (currentWord.word is CleanWord) {
            if (currentWord.isTapped) {
              _wrongWords.add(currentWord.word);
              _numberOfMarkedWords++;
            }
          } else {
            _mutatedWords.add(currentWord.word);
            if (currentWord.isTapped) _numberOfMarkedWords++;
          }
        });

      _result = Result(
        text: text,
        mutatedWords: _mutatedWords,
        numberOfMarkedWords: _numberOfMarkedWords,
        wrongWords: _wrongWords,
      );
    });
  }
}
