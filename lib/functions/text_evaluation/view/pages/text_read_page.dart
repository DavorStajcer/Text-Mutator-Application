import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../text_load/view/text_load_bloc/text_bloc.dart';
import '../../../../core/widgets/dialog.dart';
import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/bottom_page_navitator.dart';
import '../../../mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import '../text_evaluation_bloc/textevaluation_bloc.dart';
import '../../../text_mutation/view/mutate_bloc/mutate_bloc.dart';

class TextReadPage extends StatelessWidget {
  const TextReadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;
    final ProgressAnimationCubit _progressAnimationCubit =
        BlocProvider.of<ProgressAnimationCubit>(context);
    final MutateBloc _mutateBloc = BlocProvider.of<MutateBloc>(context);
    final TextBloc _textBloc = BlocProvider.of<TextBloc>(context);

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
            BlocConsumer<MutateBloc, MutateState>(
              listener: (context, mutateState) {
                if (mutateState is MutateError)
                  showNotificationDialog(context, mutateState.message, _theme);
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
                return BottomPageNavigator(
                  backOnTapFunction: () => _progressAnimationCubit.pageBack(),
                  proceedeOnTapFunction: () {},
                  proceedWidget: AppButton(
                    text: 'Mutate.',
                    onTap: () => _mutateBloc.add(
                      MutateText(
                        evaluationState.textEvaluationModel,
                        _textBloc.state is! TextLoaded,
                      ),
                    ),
                    widthSizeFactor: 2.8,
                  ),
                  deviceSize: _deviceSize,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
