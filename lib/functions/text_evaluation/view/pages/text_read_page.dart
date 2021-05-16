import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/core/widgets/bottom_page_navitator.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import 'package:text_mutator/functions/text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';

class TextReadPage extends StatelessWidget {
  const TextReadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;
    final ProgressAnimationCubit _progressAnimationCubit =
        BlocProvider.of<ProgressAnimationCubit>(context);
    final MutateBloc _mutateBloc = BlocProvider.of<MutateBloc>(context);

    return BlocBuilder<TextEvaluationBloc, TextEvaluationState>(
      builder: (context, evaluationState) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        evaluationState.textEvaluationModel.text.text,
                        style: _theme.textTheme.bodyText1!.copyWith(
                            letterSpacing: 1.5, height: 2, wordSpacing: 1.5),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BottomPageNavigator(
              backOnTapFunction: () => _progressAnimationCubit.pageBack(),
              proceedeOnTapFunction: () {},
              proceedWidget: BlocConsumer<MutateBloc, MutateState>(
                listener: (context, mutateState) {
                  if (mutateState is MutateError)
                    log('error ${mutateState.message}');
                  else if (mutateState is MutateLoaded) {
                    Navigator.of(context).pushReplacementNamed(
                      ROUTE_MUTATED_TEXT_PAGE,
                    );
                  }
                },
                builder: (context, mutateState) {
                  if (mutateState is MutateLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return AppButton(
                    text: 'Mutate.',
                    onTap: () => _mutateBloc.add(
                      MutateText(
                        evaluationState.textEvaluationModel,
                      ),
                    ),
                    widthSizeFactor: 2.8,
                  );
                },
              ),
              deviceSize: _deviceSize,
            ),
          ],
        );
      },
    );
  }
}
