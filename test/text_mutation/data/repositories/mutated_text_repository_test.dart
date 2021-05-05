import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';

void main() {
  final MutatedTextRepositoryImpl mutatedTextRepository =
      MutatedTextRepositoryImpl();

  // final MutatedText _testMutatedText =
  //     MutatedText([CleanWord(index: 4, word: '')], []);
  final List<CleanWord> _testCleanWords = [
    CleanWord(word: 'Test', index: 0),
    CleanWord(word: 'words', index: 1),
  ];
  final String _testCleanText = 'Test words';

  test(
    'should parse text to list of clean words',
    () async {
      // arrange

      // act
      final words = mutatedTextRepository.parseText(_testCleanText);
      // assert
      expect(words, equals(_testCleanWords));
    },
  );
}
