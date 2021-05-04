import 'dart:math';

import 'words.dart';

List<String> getWords(int numberOfWords) {
  final Random _rand = Random();
  final List<String> _words = [];
  for (int i = 0; i < numberOfWords; i++) {
    //178180
    _words.add(words[_rand.nextInt(178180)]);
  }
  return _words;
}
