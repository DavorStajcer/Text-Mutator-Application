import 'dart:math';

import 'package:text_mutator/data/models/words/mutated_word.dart';
import 'package:text_mutator/dummy_mutate_words.dart';

import '../models/mutated_text.dart';
import '../models/text.dart';

class MutatedTextRepository {
  MutatedText _mutatedText;

  MutatedTextRepository();

  void setMutatedText(MutatedText text) => _mutatedText;

  //Ubacuje se broj mutiranih riječi po min(brojMutacija, duzinaTekstaZaMutiranje)
  Future<void> mutateText(Text textToMutate, int numberOfMutations) {
    return Future(() {
      Random _random = new Random();
      List<int> _mutationIndexes = [];
      List<MutatedWord> _mutatedWords = [];

      for (int i = 0;
          i < numberOfMutations && i < textToMutate.text.length;
          i++) {
        //da se ne ponavljaju isti indexi, spriejčava da bude 4 instance mutated word, a samo 1 riječč da se prikaže je rimaju iste indekse
        int _newIndex = _random.nextInt(textToMutate.text.length);
        // print(_mutationIndexes.contains(_newIndex));
        // print(_mutationIndexes.toString() + "::::" + _newIndex.toString());
        while (_mutationIndexes.contains(_newIndex)) {
          _newIndex = _random.nextInt(textToMutate.text.length);
        }
        _mutationIndexes.add(_newIndex);

        final String _randomWord =
            dummyWords.elementAt(_random.nextInt(dummyWords.length - 1));

        _mutatedWords
            .add(MutatedWord(word: _randomWord, index: _mutationIndexes[i]));
      }

      _mutatedText = MutatedText(textToMutate, _mutatedWords);
      print(_mutatedWords);
      print(_mutationIndexes);
    });
  }

  MutatedText get mutatedTex => _mutatedText;
}
