import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/widgets/bottom_page_navitator.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import 'package:text_mutator/functions/text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
import 'package:text_mutator/functions/text_evaluation/view/widgets/checkbox_evaluation_row.dart';
import 'package:text_mutator/functions/text_evaluation/view/widgets/difficulty_represetnation_widget.dart';
import 'package:text_mutator/functions/text_load/view/text_load_bloc/text_bloc.dart';

class TextEvaluationPage extends StatelessWidget {
  const TextEvaluationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;
    final ProgressAnimationCubit _progressAnimationCubit =
        BlocProvider.of<ProgressAnimationCubit>(context);
    final TextEvaluationBloc _textEvaluationBloc =
        BlocProvider.of<TextEvaluationBloc>(context);

    return BlocBuilder<TextEvaluationBloc, TextEvaluationState>(
      builder: (context, state) => Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AutoSizeText(
                    'Text difficulty        ${state.textEvaluationModel.text.textDifficulty}',
                    style: _theme.textTheme.bodyText1,
                  ),
                  Container(
                    height: 40,
                  ),
                  AutoSizeText(
                    'Mutations',
                    style: _theme.textTheme.bodyText1,
                  ),
                  AutoSizeText(
                    '${state.textEvaluationModel.numberOfMutations}/${state.textEvaluationModel.maxNumberOfMutations}',
                    style: _theme.textTheme.bodyText1,
                  ),
                  CheckBoxEvaluationRow(
                    onChanged: (bool? value) =>
                        _textEvaluationBloc.add(TextConjuctionsChanged(value!)),
                    theme: _theme,
                    value: state.textEvaluationModel.includeConjuctions,
                    valueName: 'Conjuctions',
                  ),
                  CheckBoxEvaluationRow(
                    onChanged: (bool? value) => _textEvaluationBloc
                        .add(TextSyncategorematicChanged(value!)),
                    theme: _theme,
                    value: state.textEvaluationModel.includeSyncategorematic,
                    valueName: 'Synccategorematic',
                  ),
                  Expanded(
                    child: DifficultyRepresentationWidget(
                      difficulty:
                          state.textEvaluationModel.resultDifficulty.toInt(),
                      textStyle: _theme.textTheme.headline3!,
                      circleRepresentationColor: _theme.accentColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          BottomPageNavigator(
            backOnTapFunction: () {
              BlocProvider.of<TextBloc>(context)
                  .add(SetText(state.textEvaluationModel.text));
              _progressAnimationCubit.pageBack();
            },
            proceedeOnTapFunction: () => _progressAnimationCubit.pageForward(),
            proceedWidget: AutoSizeText(
              'Next ->',
              style: _theme.textTheme.headline3!
                  .copyWith(color: _theme.accentColor),
            ),
            deviceSize: _deviceSize,
          ),
        ],
      ),
    );
  }
}
