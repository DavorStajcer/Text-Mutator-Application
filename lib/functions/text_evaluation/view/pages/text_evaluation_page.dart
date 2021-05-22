import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/bottom_page_navitator.dart';
import '../../../../core/widgets/text_data_display_row_widget.dart';
import '../../../mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import '../text_evaluation_bloc/textevaluation_bloc.dart';
import '../../../../core/widgets/circular_data_represetnation_widget.dart';
import '../widgets/hard_words_options_widget.dart';
import '../widgets/mutations_slider_widget.dart';
import '../../../text_load/view/text_load_bloc/text_bloc.dart';

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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: TextDataDisplayRow(
                              theme: _theme,
                              text: 'Text Difficulty',
                              data:
                                  '${_convertTextDifficultyToString(state.textEvaluationModel.text.textDifficulty)}',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: MutationsSliderWidget(
                              currentSliderValue: state
                                  .textEvaluationModel.numberOfMutations
                                  .toDouble(),
                              maximumSliderValue: state
                                  .textEvaluationModel.maxNumberOfMutations
                                  .toDouble(),
                              theme: _theme,
                              textEvaluationBloc: _textEvaluationBloc),
                        ),
                        Expanded(
                          flex: 3,
                          child: HardWordsOptionsWidget(
                              includeConjuctions:
                                  state.textEvaluationModel.includeConjuctions,
                              includeSynccategorematic: state
                                  .textEvaluationModel.includeSyncategorematic,
                              textEvaluationBloc: _textEvaluationBloc,
                              theme: _theme),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: CircularDataRepresentationWidget(
                      innerCircleRadialGradientColor: _theme.primaryColor,
                      outerCircleRadialGradiantColor: _theme.accentColor,
                      data: state.textEvaluationModel.resultDifficulty.toInt(),
                      textStyle: _theme.textTheme.headline3!,
                      circleRepresentationColor: _theme.accentColor,
                      dataRepresentationTitle: 'DIFFICULTY',
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

String _convertTextDifficultyToString(TextDifficulty textDifficulty) {
  return textDifficulty.toString().split('.')[1];
}
