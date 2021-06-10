import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_difficulty_representation_cubit/results_difficulty_representation_cubit.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_graph_bloc/results_graph_bloc.dart';
import 'package:text_mutator/functions/result_presentation/view/widgets/graph_difficulty_selection.dart';

final List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class ResultsGraph extends StatelessWidget {
  const ResultsGraph(ResultsGraphLoaded resultsState, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

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
              child: BlocBuilder<ResultsDifficultyRepresentationCubit,
                  ResultsDifficultyRepresentationState>(
                builder: (context, representationState) {
                  return LineChart(
                    mainData(
                      _theme,
                      representationState.resultsToShow,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        GrapDifficultySelecetion(),
      ],
    );
  }

  LineChartData mainData(ThemeData theme, List<Result> resultsToShow) {
    final List<FlSpot> _graphSpots = [
      resultsToShow.isEmpty
          ? FlSpot(1, 0)
          : FlSpot(1, resultsToShow.first.score)
    ];
    for (var i = 0; i < resultsToShow.length; i++) {
      _graphSpots.add(FlSpot(i.toDouble() + 1, resultsToShow[i].score));
    }

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
        bottomTitles: SideTitles(rotateAngle: 60, showTitles: false),
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
      minX: 1,
      maxX: resultsToShow.length.toDouble(),
      minY: 0,
      maxY: 100,
      borderData: FlBorderData(show: false),
      axisTitleData: FlAxisTitleData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _graphSpots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}
