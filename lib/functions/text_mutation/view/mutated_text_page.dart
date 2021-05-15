import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';
import 'package:text_mutator/functions/result_presentation/view/result_bloc/result_bloc.dart';

import '../domain/models/mutated_text.dart';
import '../domain/models/word/mutated_word.dart';
import 'mutate_bloc/mutate_bloc.dart';

class MutatedTextPage extends StatelessWidget {
  MutatedTextPage({Key? key}) : super(key: key);

  // void _clearAllText() {
  //   _allText.forEach((element) {
  //     element.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ResultBloc>(),
      child: Scaffold(
        body: BlocBuilder<ResultBloc, ResultState>(
          builder: (context, state) {
            if (state is ResultLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ResultLoaded) {
              return Column(
                children: [
                  Text("Result:" + state.result.score.toString()),
                  Text("Number of mutated words:" +
                      state.result.mutatedWords.toString()),
                  Text("Number of wrongly marked words: " +
                      state.result.wrongWords.toString()),
                  Text("Number of selected words: " +
                      state.result.numberOfMarkedWords.toString()),
                  TextButton(
                    onPressed: () {
                      // _clearAllText();
                    },
                    child: Text("Repeat"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Abandone result."),
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 800,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        color: Colors.grey[200],
                      ),
                      child: BlocBuilder<MutateBloc, MutateState>(
                        builder: (context, state) {
                          if (state is MutateLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is MutateInitial) {
                            return Center(
                              child: Center(
                                child: Text("Initial state."),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Back"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
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
                        ? defaultStyle!
                            .copyWith(decoration: TextDecoration.lineThrough)
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
}
