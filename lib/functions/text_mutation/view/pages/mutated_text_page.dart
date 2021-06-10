import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/dialog.dart';
import '../../../result_presentation/view/blocs/result_bloc/result_bloc.dart';
import '../mutate_bloc/mutate_bloc.dart';
import '../widgets/build_selectable_text.dart';

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
                          showNotificationDialog(
                              context, resultState.message, _theme);
                        else if (resultState is ResultLoaded)
                          Navigator.of(context)
                              .pushNamed(ROUTE_RESULT_FINISHED_PAGE);
                      },
                      builder: (context, resultState) {
                        if (resultState is ResultLoading)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppButton(
                            text: 'Done.',
                            onTap: () => _resultBloc.add(
                              CreateResult(mutationState.mutateText),
                            ),
                            widthSizeFactor: 2.8,
                          ),
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
