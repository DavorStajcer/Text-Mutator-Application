import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';
import 'package:text_mutator/dummy_mutate_words.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';
import 'package:text_mutator/functions/text_mutation/domain/repositories/mutated_text_repository.dart';

import '../../domain/models/mutated_text.dart';

class MutatedTextRepositoryImpl extends MutatedTextRepository {
  MutatedText? _mutatedText;
  final Random _random = new Random();

  MutatedTextRepositoryImpl();

  void setMutatedText(MutatedText text) => _mutatedText;
  MutatedText? get mutatedTex => _mutatedText;

  void updateWord(Word word) {
    if (word is CleanWord) {
      final _index = _mutatedText!.cleanWords
          .indexWhere((element) => element.index == word.index);
      _mutatedText!.cleanWords[_index] = word;
    } else {
      final _index = _mutatedText!.mutatedWords
          .indexWhere((element) => element!.index == word.index);
      _mutatedText!.mutatedWords[_index] = word as MutatedWord?;
    }
  }

  @visibleForTesting
  List<CleanWord> parseText(String text) {
    List<CleanWord> _words = [];

    List<String> _verginWords = text.split(' ');

    for (int index = 0; index < _verginWords.length; index++) {
      _words.add(CleanWord(
        word: _verginWords.elementAt(index),
        index: index,
      ));
    }

    return _words;
  }

  //Ubacuje se broj mutiranih riječi po min(brojMutacija, duzinaTekstaZaMutiranje)
  Future<Either<Failure, void>> mutateText(
      String textToMutate, int numberOfMutations) {
    return Future(() {
      List<int> _mutationIndexes = [];
      List<MutatedWord> _mutatedWords = [];
      List<CleanWord> _cleanWords = parseText(textToMutate);

      for (int i = 0; i < numberOfMutations && i < _cleanWords.length; i++) {
        //da se ne ponavljaju isti indexi, spriejčava da bude 4 instance mutated word, a samo 1 riječč da se prikaže je rimaju iste indekse
        int _newIndex = _random.nextInt(_cleanWords.length);
        // print(_mutationIndexes.contains(_newIndex));
        // print(_mutationIndexes.toString() + "::::" + _newIndex.toString());
        while (_mutationIndexes.contains(_newIndex)) {
          _newIndex = _random.nextInt(_cleanWords.length);
        }
        _mutationIndexes.add(_newIndex);

        final String _randomWord =
            dummyWords.elementAt(_random.nextInt(dummyWords.length - 1));

        _mutatedWords
            .add(MutatedWord(word: _randomWord, index: _mutationIndexes[i]));
      }

      _mutatedText = MutatedText(_cleanWords, _mutatedWords);
      return Right(null);
    });
  }
}
