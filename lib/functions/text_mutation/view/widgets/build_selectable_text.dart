import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/theme.dart';
import '../../domain/models/mutated_text.dart';
import '../../domain/models/word/mutated_word.dart';
import '../../domain/models/word/word.dart';
import '../mutate_bloc/mutate_bloc.dart';

Widget buildSelectableText(
    MutatedText mutatedText, TextStyle defaultStyle, MutateBloc mutateBloc) {
  final _allText = <Word>[];

  for (int index = 0; index < mutatedText.cleanWords.length; index++) {
    _allText.add(mutatedText.cleanWords[index]);
    final MutatedWord _mutatedWord = mutatedText.mutatedWords.firstWhere(
        (MutatedWord mutatedWord) => mutatedWord.index == index,
        orElse: () => MutatedWord(word: '', index: -1));

    if (_mutatedWord.index >= 0) _allText.add(_mutatedWord);
  }

  return RichText(
    textAlign: TextAlign.justify,
    softWrap: true,
    text: TextSpan(
      text: "",
      children:
          _mapWordsToCrossableTextSpans(_allText, defaultStyle, mutateBloc)
              .toList(),
    ),
  );
}

Iterable<TextSpan> _mapWordsToCrossableTextSpans(
    List<Word> _allText, TextStyle defaultStyle, MutateBloc mutateBloc) {
  final textSpans = _allText.map(
    (Word e) => TextSpan(
      text: e.word,
      style: e.isSelected
          ? defaultStyle.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationColor: DARK_WRONGLY_SELECTED_COLOR,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 2.5,
              color: FADED_TEXT,
            )
          : defaultStyle,
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          HapticFeedback.vibrate();
          e.isSelected = !e.isSelected;
          mutateBloc.add(UpdateWord(e));
        },
    ),
  );
  return textSpans.toList().expand((element) => [element, TextSpan(text: " ")]);
}
