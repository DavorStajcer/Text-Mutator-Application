import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/functions/result_presentation/view/result_bloc/result_bloc.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'package:text_mutator/functions/text_mutation/view/widgets/build_selectable_text.dart';

class MutatedTextPage extends StatelessWidget {
  const MutatedTextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final MutateBloc _mutateBloc = BlocProvider.of<MutateBloc>(context);
    final ResultBloc _resultBloc = BlocProvider.of<ResultBloc>(context);

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
                      'Mark the imposter words!',
                      style: _theme.textTheme.headline3!
                          .copyWith(color: _theme.accentColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildSelectableText(
                        mutationState.mutateText,
                        _theme.textTheme.bodyText1!.copyWith(
                            letterSpacing: 1.5, height: 2, wordSpacing: 1.5),
                        _mutateBloc,
                      ),
                    ),
                    BlocConsumer<ResultBloc, ResultState>(
                      listener: (context, resultState) {
                        if (resultState is ResultError)
                          log('error ${resultState.message}');
                        else if (resultState is ResultLoaded)
                          Navigator.of(context)
                              .pushNamed(ROUTE_RESULT_FINISHED_PAGE);
                      },
                      builder: (context, resultState) {
                        if (resultState is ResultLoading)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return AppButton(
                          text: 'Done.',
                          onTap: () => _resultBloc.add(
                            CreateResult(mutationState.mutateText),
                          ),
                          widthSizeFactor: 2.8,
                        );
                      },
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
