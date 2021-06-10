import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/results_difficulty_representation_cubit/results_difficulty_representation_cubit.dart';
import '../blocs/results_graph_bloc/results_graph_bloc.dart';
import '../widgets/results_graph.dart';
import '../widgets/user_results_preview_list.dart';
import '../../../theme_managment/cubit/theme_changing_cubit.dart';

class UserResultsPreviewPage extends StatelessWidget {
  UserResultsPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      appBar: AppBar(),
      body: BlocConsumer<ResultsGraphBloc, ResultsGraphState>(
        listener: (context, resultsState) {
          if (resultsState is ResultsGraphLoaded)
            BlocProvider.of<ResultsDifficultyRepresentationCubit>(context)
                .initializeResults(resultsState.results);
        },
        builder: (context, resultsState) {
          if (resultsState is ResultsGraphLoaded) {
            return _buildGraphResultsLoaded(resultsState, _theme, _deviceSize);
          }

          if (resultsState is ResultsGraphError) {
            return _buildResultsGraphError(resultsState, _theme);
          }

          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }

  RenderObjectWidget _buildGraphResultsLoaded(
      ResultsGraphLoaded resultsState, ThemeData _theme, Size _deviceSize) {
    if (resultsState.results.isEmpty) {
      return _buildNoResultsToShow(_theme, _deviceSize);
    }

    return Column(
      children: [
        ResultsGraph(resultsState),
        Expanded(
          child: UserResultsPreviewList(),
        ),
      ],
    );
  }

  Center _buildResultsGraphError(
      ResultsGraphError resultsState, ThemeData _theme) {
    return Center(
      child: AutoSizeText(
        resultsState.message,
        textAlign: TextAlign.center,
        style: _theme.textTheme.headline2,
      ),
    );
  }

  Center _buildNoResultsToShow(ThemeData _theme, Size deviceSize) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
              builder: (context, themeState) {
                return SvgPicture.asset(
                  'assets/svg/no_results.svg',
                  height: deviceSize.height / 4,
                  width: deviceSize.width,
                  color:
                      themeState.isLight ? Colors.black87 : _theme.accentColor,
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: AutoSizeText(
                'No reuslts yet to show.\nTry out practice to achieve a result!',
                style: _theme.textTheme.headline2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
