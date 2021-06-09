import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_difficulty_representation_cubit/results_difficulty_representation_cubit.dart';

class UserResultsPreviewList extends StatelessWidget {
  const UserResultsPreviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ResultsDifficultyRepresentationCubit,
          ResultsDifficultyRepresentationState>(
        builder: (context, resultsDifficultyState) {
          if (resultsDifficultyState.resultsToShow.isEmpty) {
            return Container(
              child: Center(
                child: AutoSizeText('No results to show.'),
              ),
            );
          }

          return ListView.builder(
              itemCount: resultsDifficultyState.resultsToShow.length,
              itemBuilder: (ctx, index) {
                final Result _currentResult =
                    resultsDifficultyState.resultsToShow[index];

                return Container(
                  constraints: BoxConstraints(maxHeight: 100),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _theme.textTheme.bodyText1!.color!.withAlpha(140),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AutoSizeText(
                                      'score: ',
                                      maxLines: 1,
                                      style: _theme.textTheme.bodyText1,
                                    ),
                                    AutoSizeText(
                                      _currentResult.score.toStringAsFixed(2),
                                      maxLines: 1,
                                      style: _theme.textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _theme
                                              .textTheme.bodyText1!.color!
                                              .withAlpha(140),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: _currentResult.score / 100,
                                      child: Container(
                                        margin: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.lightBlue[800]!,
                                              _theme.accentColor
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AutoSizeText(
                                      'difficulty: ',
                                      maxLines: 1,
                                      style: _theme.textTheme.bodyText1,
                                    ),
                                    AutoSizeText(
                                      _currentResult.difficulty
                                          .toStringAsFixed(2),
                                      maxLines: 1,
                                      style: _theme.textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  DateFormat.yMMMd()
                                      .format(_currentResult.date),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: _theme.textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
