import 'package:flutter/material.dart';
import 'package:text_mutator/functions/text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
import 'package:text_mutator/functions/text_evaluation/view/widgets/checkbox_evaluation_row.dart';

class HardWordsOptionsWidget extends StatelessWidget {
  const HardWordsOptionsWidget({
    Key? key,
    required TextEvaluationBloc textEvaluationBloc,
    required ThemeData theme,
    required this.includeConjuctions,
    required this.includeSynccategorematic,
  })   : _textEvaluationBloc = textEvaluationBloc,
        _theme = theme,
        super(key: key);

  final TextEvaluationBloc _textEvaluationBloc;
  final ThemeData _theme;
  final bool includeConjuctions;
  final bool includeSynccategorematic;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CheckBoxEvaluationRow(
            onChanged: (bool? value) =>
                _textEvaluationBloc.add(TextConjuctionsChanged(value!)),
            theme: _theme,
            value: includeConjuctions,
            valueName: 'Conjuctions',
          ),
        ),
        Expanded(
          child: CheckBoxEvaluationRow(
            onChanged: (bool? value) =>
                _textEvaluationBloc.add(TextSyncategorematicChanged(value!)),
            theme: _theme,
            value: includeSynccategorematic,
            valueName: 'Synccategorematic',
          ),
        ),
      ],
    );
  }
}
