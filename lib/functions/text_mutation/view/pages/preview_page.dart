import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/theme.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'package:text_mutator/functions/text_mutation/view/widgets/buil_preview_text.dart';
import 'package:text_mutator/functions/text_mutation/view/widgets/preview_color_indicator.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: BlocBuilder<MutateBloc, MutateState>(
        builder: (context, mutationState) {
          if (mutationState is MutateLoaded) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    AutoSizeText(
                      'Results Preview',
                      style: _theme.textTheme.headline3!,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PreviewColorIndicator(
                            meaningTextStyle: _theme.textTheme.bodyText1!,
                            previewColor: _theme.accentColor,
                            previewMeaning: 'Correct',
                          ),
                          PreviewColorIndicator(
                            meaningTextStyle: _theme.textTheme.bodyText1!,
                            previewColor: LIGHT_WRONGLY_SELECTED_COLOR,
                            previewMeaning: 'Wrong',
                          ),
                          PreviewColorIndicator(
                            meaningTextStyle: _theme.textTheme.bodyText1!,
                            previewColor: LIGHT_MISSED_SELECTION_COLOR,
                            previewMeaning: 'Missed',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildPreviewText(
                        mutationState.mutateText,
                        _theme,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButton(
                        text: 'Okay',
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    )
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
