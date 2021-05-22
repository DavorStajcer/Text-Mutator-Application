import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/circular_data_represetnation_widget.dart';
import '../../../../core/widgets/text_data_display_row_widget.dart';
import '../result_bloc/result_bloc.dart';

class ResultFinishedPage extends StatelessWidget {
  const ResultFinishedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _screenSize = MediaQuery.of(context).size;
    final AutoSizeGroup _autoSizeGroup = AutoSizeGroup();

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, resultState) {
          if (resultState is ResultLoaded) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CircularDataRepresentationWidget(
                        data: resultState.result.score.toInt(),
                        innerCircleRadialGradientColor: _theme.primaryColor,
                        outerCircleRadialGradiantColor: _theme.accentColor,
                        textStyle: _theme.textTheme.headline3!,
                        circleRepresentationColor: _theme.accentColor,
                        dataRepresentationTitle: 'YOUR   RESULT',
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenSize.width / 8),
                        child: Column(
                          children: [
                            Expanded(
                              child: TextDataDisplayRow(
                                theme: _theme,
                                text: 'Difficulty',
                                autoSizeGroup: _autoSizeGroup,
                                data: resultState.result.difficulty
                                    .toInt()
                                    .toString(),
                              ),
                            ),
                            Expanded(
                              child: TextDataDisplayRow(
                                theme: _theme,
                                text: 'Marked words',
                                autoSizeGroup: _autoSizeGroup,
                                data: resultState.result.numberOfMarkedWords
                                    .toString(),
                              ),
                            ),
                            Expanded(
                              child: TextDataDisplayRow(
                                theme: _theme,
                                autoSizeGroup: _autoSizeGroup,
                                text: 'Mutated words',
                                data: resultState.result.numberOfMutatedWords
                                    .toString(),
                              ),
                            ),
                            Expanded(
                              child: TextDataDisplayRow(
                                theme: _theme,
                                autoSizeGroup: _autoSizeGroup,
                                text: 'Wrongly marked words',
                                data: resultState.result.numberOfWrongWords
                                    .toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppButton(
                            text: 'Preview',
                            widthSizeFactor: 2.8,
                            onTap: () => Navigator.of(context)
                                .pushNamed(ROUTE_RESULT_PREVIEW_PAGE),
                          ),
                          AppButton(
                            text: 'Home',
                            widthSizeFactor: 2.8,
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(ROUTE_HOME_PAGE),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
