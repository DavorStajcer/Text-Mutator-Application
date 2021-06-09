import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../text_evaluation_bloc/textevaluation_bloc.dart';

class MutationsSliderWidget extends StatelessWidget {
  const MutationsSliderWidget({
    Key? key,
    required ThemeData theme,
    required TextEvaluationBloc textEvaluationBloc,
    required this.maximumSliderValue,
    required this.currentSliderValue,
  })  : _theme = theme,
        _textEvaluationBloc = textEvaluationBloc,
        super(key: key);

  final ThemeData _theme;
  final TextEvaluationBloc _textEvaluationBloc;
  final double maximumSliderValue;
  final double currentSliderValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AutoSizeText(
            'Mutations',
            maxLines: 1,
            style: _theme.textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ),
        Expanded(
          flex: 2,
          child: Slider(
            value: currentSliderValue,
            max: maximumSliderValue,
            min: 8,
            activeColor: _theme.textTheme.bodyText1!.color,
            inactiveColor: _theme.textTheme.bodyText1!.color,
            onChanged: (newValue) => _textEvaluationBloc.add(
              TextMutationsChanged(
                newValue.toInt(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: AutoSizeText(
            '${currentSliderValue.toInt()}/${maximumSliderValue.toInt()}',
            style: _theme.textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w700, fontSize: 25),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
