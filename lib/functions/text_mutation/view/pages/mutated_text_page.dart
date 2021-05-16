import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/theme.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';

class MutatedTextPage extends StatelessWidget {
  const MutatedTextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final MutateBloc _mutateBloc = BlocProvider.of<MutateBloc>(context);

    return Scaffold(
      body: BlocBuilder<MutateBloc, MutateState>(
        builder: (context, state) {
          if (state is MutateLoaded) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    AutoSizeText(
                      'Mark the imposter words!',
                      style: _theme.textTheme.headline3!
                          .copyWith(color: _theme.accentColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildSelectableText(
                        state.mutateText,
                        _theme.textTheme.bodyText1!.copyWith(
                            letterSpacing: 1.5, height: 2, wordSpacing: 1.5),
                        _mutateBloc,
                      ),
                    ),
                    AppButton(
                      text: 'Done.',
                      onTap: () {},
                      widthSizeFactor: 2.8,
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

Widget _buildSelectableText(
    MutatedText mutatedText, TextStyle? defaultStyle, MutateBloc mutateBloc) {
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
                (Word e) => TextSpan(
                  text: e.word + ' ',
                  style: e.isSelected
                      ? defaultStyle!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: LIGHT_WRONGLY_SELECTED_COLOR,
                          fontSize: defaultStyle.fontSize! - 2,
                        )
                      : defaultStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      HapticFeedback.vibrate();
                      //setState(() {
                      e.isSelected = !e.isSelected;
                      mutateBloc.add(UpdateWord(e));
                      //});
                    },
                ),
              )
              .toList()));
}
