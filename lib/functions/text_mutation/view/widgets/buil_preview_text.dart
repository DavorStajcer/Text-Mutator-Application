import 'package:flutter/material.dart';
import '../../../../core/constants/theme.dart';
import '../../domain/models/mutated_text.dart';
import '../../domain/models/word/clean_word.dart';
import '../../domain/models/word/mutated_word.dart';
import '../../domain/models/word/word.dart';

TextStyle _determineStyleColorOfTheWord(Word word, ThemeData theme) {
  final TextStyle _defaultStyle = theme.textTheme.bodyText1!.copyWith(
      letterSpacing: 1.5,
      height: 2,
      wordSpacing: 1.5,
      fontWeight: FontWeight.w700);
  if (word is CleanWord) {
    return word.isSelected
        ? _defaultStyle.copyWith(color: LIGHT_WRONGLY_SELECTED_COLOR)
        : _defaultStyle.copyWith(
            color: _defaultStyle.color!.withAlpha(100),
            fontWeight: FontWeight.normal);
  } else {
    return word.isSelected
        ? _defaultStyle.copyWith(color: theme.accentColor)
        : _defaultStyle.copyWith(color: LIGHT_MISSED_SELECTION_COLOR);
  }
}

Widget buildPreviewText(MutatedText mutatedText, ThemeData theme) {
  final _allText = <Word>[];
  for (int index = 0; index < mutatedText.cleanWords.length; index++) {
    // _allText.add(SelectableTextWidget(mutatedText.cleanWords[index]));

    _allText.add(mutatedText.cleanWords[index]);

    final MutatedWord _mutatedWord = mutatedText.mutatedWords.firstWhere(
        (MutatedWord mutatedWord) => mutatedWord.index == index,
        orElse: () => MutatedWord(word: '', index: -1));

    if (_mutatedWord.index >= 0) _allText.add(_mutatedWord);
  }

  return RichText(
      textAlign: TextAlign.left,
      softWrap: true,
      text: TextSpan(
          text: "",
          children: _allText
              .map(
                (Word word) => TextSpan(
                  text: word.word + ' ',
                  style: _determineStyleColorOfTheWord(word, theme),
                ),
              )
              .toList()));
}
