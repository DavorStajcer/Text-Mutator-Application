import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_graph_bloc/results_graph_bloc.dart';

int getDayDateDifference(DateTime date, DateTime referenceDate) {
  final Duration _difference = date.difference(referenceDate);
  return _difference.inDays;
}

class UserResultsPreviewPage extends StatelessWidget {
  UserResultsPreviewPage({Key? key}) : super(key: key);

  final List<Result> _dummyResults = [
    Result(
      numberOfMutatedWords: 4,
      numberOfWrongWords: 2,
      numberOfMarkedWords: 4,
      dateOfResult: DateTime(2021, 4, 26),
      difficulty: 50,
      id: 'id1',
    ),
    Result(
      numberOfMutatedWords: 10,
      numberOfWrongWords: 2,
      numberOfMarkedWords: 10,
      difficulty: 70,
      dateOfResult: DateTime(2021, 8, 26),
      id: 'id2',
    ),
    Result(
      numberOfMutatedWords: 43,
      numberOfWrongWords: 10,
      numberOfMarkedWords: 38,
      difficulty: 68,
      dateOfResult: DateTime(2021, 10, 26),
      id: 'id4',
    ),
    Result(
      numberOfMutatedWords: 44,
      numberOfWrongWords: 24,
      numberOfMarkedWords: 44,
      difficulty: 100,
      dateOfResult: DateTime(2021, 12, 26),
      id: 'id3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [ResultsGraph()],
        ),
      ),
    );
  }
}

final List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class ResultsGraph extends StatelessWidget {
  const ResultsGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return BlocBuilder<ResultsGraphBloc, ResultsGraphState>(
      builder: (context, resultsState) {
        if (resultsState is ResultsGraphLoaded) {
          if (resultsState.results.isEmpty) {
            return Center(
              child: AutoSizeText(
                'No reuslts yet to show.\n Try out practice to achieve a result!',
                style: _theme.textTheme.headline2,
              ),
            );
          }

          int _maxResultDay = 1;

          resultsState.results.forEach((element) {
            final int _tempMaxDay = getDayDateDifference(
              element.date,
              resultsState.results.first.date,
            );
            if (_tempMaxDay > _maxResultDay) {
              _maxResultDay = _tempMaxDay;
            }
          });

          log(_maxResultDay.toString());

          return Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: _theme.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      mainData(
                        _theme,
                        _maxResultDay,
                        resultsState.results,
                        resultsState.results.first.date,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (resultsState is ResultsGraphError) {
          return Center(
            child: AutoSizeText(
              resultsState.message,
              style: _theme.textTheme.headline2,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  LineChartData mainData(ThemeData theme, int maxDay, List<Result> results,
      DateTime referenceDate) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 50:
                return '50';
              case 100:
                return '100';
            }
            return '';
          },
          reservedSize: 18,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: maxDay.toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: results
              .map((e) => FlSpot(
                  getDayDateDifference(e.date, referenceDate).toDouble(),
                  e.score))
              .toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
