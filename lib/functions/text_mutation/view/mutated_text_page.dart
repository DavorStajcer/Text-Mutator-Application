import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/results_repository.dart';
import 'package:text_mutator/functions/text_mutation/view/result_bloc/result_bloc.dart';

import 'package:text_mutator/functions/text_mutation/view/text_bloc/text_bloc.dart';

import '../../../core/selectable_text_widget.dart';
import '../domain/enteties/mutated_text.dart';
import '../domain/enteties/word/mutated_word.dart';
import 'mutate_bloc/mutate_bloc.dart';

class MutatedTextPage extends StatelessWidget {
  MutatedTextPage({Key key}) : super(key: key);

  List<SelectableTextWidget> _allText = [];

  // void _clearAllText() {
  //   _allText.forEach((element) {
  //     element.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultBloc(ResultRepository()),
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
                      state.result.mutatedWords.length.toString()),
                  Text("Number of wrongly marked words: " +
                      state.result.wrongWords.length.toString()),
                  Text("Number of selected words: " +
                      state.result.numberOfMarkedWords.toString()),
                  TextButton(
                    onPressed: () {
                      // _clearAllText();
                      BlocProvider.of<ResultBloc>(context, listen: false)
                          .add(Restart());
                    },
                    child: Text("Repeat"),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ResultBloc>(context, listen: false)
                          .add(AbandoneResult());
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
                          } else if (state is MutateLoaded) {
                            return Column(
                              children: [
                                Expanded(
                                    child: _buildSelectableText(
                                        state.mutatedText)),
                              ],
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
                      TextButton(
                        onPressed: () =>
                            BlocProvider.of<ResultBloc>(context, listen: false)
                                .add(CreateResult(
                                    _allText,
                                    BlocProvider.of<TextBloc>(context,
                                            listen: false)
                                        .getText)),
                        child: Text("Check"),
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

  Widget _buildSelectableText(MutatedText mutatedText) {
    _allText = [];
    for (int index = 0; index < mutatedText.text.text.length; index++) {
      _allText
          .add(SelectableTextWidget(mutatedText.text.text.elementAt(index)));

      final MutatedWord _mutatedWord = mutatedText.mutatedWords.firstWhere(
          (MutatedWord mutatedWord) => mutatedWord.index == index, orElse: () {
        return null;
      });

      if (_mutatedWord != null)
        _allText.add(SelectableTextWidget(_mutatedWord));
    }

    return RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            text: "",
            children: _allText
                .map((SelectableTextWidget e) => WidgetSpan(child: e))
                .toList()));
  }
}
