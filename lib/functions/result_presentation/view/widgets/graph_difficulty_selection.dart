import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_difficulty_representation_cubit/results_difficulty_representation_cubit.dart';

class GrapDifficultySelecetion extends StatelessWidget {
  const GrapDifficultySelecetion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResultsDifficultyRepresentationCubit
        _resultsDifficultyRepresentationCubit =
        BlocProvider.of<ResultsDifficultyRepresentationCubit>(context);

    final AutoSizeGroup _buttonTextGroup = AutoSizeGroup();

    return BlocBuilder<ResultsDifficultyRepresentationCubit,
            ResultsDifficultyRepresentationState>(
        builder: (context, resultsDifficultyState) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                  child: AppButton(
                    text: 'Easy',
                    widthSizeFactor: 4,
                    autoSizeGroup: _buttonTextGroup,
                    isAvailable: resultsDifficultyState
                        is ResultsDifficultyRepresentationEasy,
                    onTap: () {
                      if (resultsDifficultyState
                          is! ResultsDifficultyRepresentationEasy) {
                        _resultsDifficultyRepresentationCubit
                            .changeRepresentation(
                                ResultsDifficultyRepresentation.Easy);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                  child: AppButton(
                    text: 'Medium',
                    widthSizeFactor: 4,
                    autoSizeGroup: _buttonTextGroup,
                    isAvailable: resultsDifficultyState
                        is ResultsDifficultyRepresentationMedium,
                    onTap: () {
                      if (resultsDifficultyState
                          is! ResultsDifficultyRepresentationMedium) {
                        _resultsDifficultyRepresentationCubit
                            .changeRepresentation(
                                ResultsDifficultyRepresentation.Medium);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                  child: AppButton(
                    text: 'Hard',
                    includeTopMaring: false,
                    widthSizeFactor: 4,
                    autoSizeGroup: _buttonTextGroup,
                    isAvailable: resultsDifficultyState
                        is ResultsDifficultyRepresentationHard,
                    onTap: () {
                      if (resultsDifficultyState
                          is! ResultsDifficultyRepresentationHard) {
                        _resultsDifficultyRepresentationCubit
                            .changeRepresentation(
                                ResultsDifficultyRepresentation.Hard);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                  child: AppButton(
                    text: 'Impossible',
                    widthSizeFactor: 4,
                    autoSizeGroup: _buttonTextGroup,
                    includeTopMaring: false,
                    isAvailable: resultsDifficultyState
                        is ResultsDifficultyRepresentationImpossible,
                    onTap: () {
                      if (resultsDifficultyState
                          is! ResultsDifficultyRepresentationImpossible) {
                        _resultsDifficultyRepresentationCubit
                            .changeRepresentation(
                                ResultsDifficultyRepresentation.Impossible);
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
