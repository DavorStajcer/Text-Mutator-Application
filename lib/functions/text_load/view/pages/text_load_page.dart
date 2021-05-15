import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/core/widgets/bottom_page_navitator.dart';
import 'package:text_mutator/core/widgets/dialog.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import 'package:text_mutator/functions/text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart'
    as text;
import 'package:text_mutator/functions/text_load/view/text_load_bloc/text_bloc.dart';
import 'package:text_mutator/functions/text_load/view/text_validation_bloc/textvalidator_bloc.dart';

class TextLoadPage extends StatefulWidget {
  const TextLoadPage({Key? key}) : super(key: key);

  @override
  _TextLoadPageState createState() => _TextLoadPageState();
}

class _TextLoadPageState extends State<TextLoadPage> {
  late final TextEditingController _textEditingController;
  late final FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  void _proceedToTextEvaluation() =>
      BlocProvider.of<TextEvaluationBloc>(context).add(
        TextEvaluationStarted(
          text.Text.createDifficulty(
            id: '',
            text: _textEditingController.text,
          ),
        ),
      );

  void _showWhyUserCanNotProceed(String text, ThemeData _theme) {
    showNotificationDialog(context, text, _theme);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;
    final ProgressAnimationCubit _progressAnimationCubit =
        BlocProvider.of<ProgressAnimationCubit>(context);
    final TextValidatorBloc _textValidatorBloc =
        BlocProvider.of<TextValidatorBloc>(context);

    return Column(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: _theme.textTheme.bodyText1!.color!,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(20),
              // color: Colors.green,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: BlocBuilder<TextBloc, TextState>(
                builder: (context, state) {
                  if (state is TextLoaded) {
                    _textEditingController.text = state.text.text;
                  }

                  return TextField(
                    controller: _textEditingController,
                    focusNode: _textFocusNode,
                    style: _theme.textTheme.bodyText1,
                    onChanged: (String text) {
                      _textEditingController.text = text;
                      _textValidatorBloc.add(TextChanged(text));
                    },
                    decoration: InputDecoration(
                      errorBorder: null,
                      enabledBorder: null,
                      focusedBorder: null,
                      disabledBorder: null,
                      focusedErrorBorder: null,
                      hintText:
                          'Load a text you wish to mutate\n or write your own',
                    ),
                    maxLines: null,
                  );
                },
              ),
            ),
          ),
        ),
        AppButton(
          text: 'Load',
          widthSizeFactor: 3,
          onTap: () {},
        ),
        Spacer(),
        BlocBuilder<TextValidatorBloc, TextValidatorState>(
          builder: (context, state) {
            return BottomPageNavigator(
              backOnTapFunction: () => _progressAnimationCubit.pageBack(),
              proceedeOnTapFunction: () {
                if (state is TextValid) {
                  FocusScope.of(context).unfocus();
                  _progressAnimationCubit.pageForward();
                  _proceedToTextEvaluation();
                } else {
                  _showWhyUserCanNotProceed(
                    state.text!,
                    _theme,
                  );
                }
              },
              proceedWidget: AutoSizeText(
                'Next ->',
                style: _theme.textTheme.headline3!.copyWith(
                  color: state is TextValid
                      ? _theme.accentColor
                      : _theme.textTheme.bodyText1!.color,
                ),
              ),
              deviceSize: _deviceSize,
            );
          },
        ),
      ],
    );
  }
}
