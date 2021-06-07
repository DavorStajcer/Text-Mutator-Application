import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/enums.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/bottom_page_navitator.dart';
import '../../../../core/widgets/dialog.dart';
import '../../../mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import '../../../text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  void _proceedToTextEvaluation(TextState textState) =>
      BlocProvider.of<TextEvaluationBloc>(context).add(
        TextEvaluationStarted(
          text.Text.createDifficulty(
            id: textState is TextLoaded ? textState.text.id : '',
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
    final TextBloc _textBloc = BlocProvider.of<TextBloc>(context);

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
              child: BlocConsumer<TextBloc, TextState>(
                listener: (ctx, textLoadState) {
                  if (textLoadState is TextError)
                    _listenTextLoadError(
                        _textValidatorBloc, ctx, textLoadState);
                },
                builder: (ctx, textLoadState) {
                  if (textLoadState is TextLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (textLoadState is TextLoaded) {
                    _textEditingController.text = textLoadState.text.text;
                    _textValidatorBloc
                        .add(TextChanged(textLoadState.text.text));
                  }

                  return _buildTextInputField(_theme, _textValidatorBloc);
                },
              ),
            ),
          ),
        ),
        AppButton(
          text: 'Load',
          widthSizeFactor: 3,
          onTap: () {
            _presentTextDifficultyPickingDialog(context, _textBloc);
          },
        ),
        Spacer(),
        BlocBuilder<TextValidatorBloc, TextValidatorState>(
          builder: (ctx, state) {
            return BottomPageNavigator(
              backOnTapFunction: () => _progressAnimationCubit.pageBack(),
              proceedeOnTapFunction: () {
                if (state is TextValid) {
                  FocusScope.of(context).unfocus();
                  _progressAnimationCubit.pageForward();
                  _proceedToTextEvaluation(_textBloc.state);
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

  TextField _buildTextInputField(
      ThemeData _theme, TextValidatorBloc _textValidatorBloc) {
    return TextField(
      controller: _textEditingController,
      textDirection: TextDirection.ltr,
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
        hintText: 'Load a text you wish to mutate\n or write your own',
      ),
      maxLines: null,
    );
  }

  void _listenTextLoadError(TextValidatorBloc _textValidatorBloc,
      BuildContext ctx, TextError textLoadState) {
    _textEditingController.text = '';
    _textValidatorBloc.add(TextChanged(''));
    ScaffoldMessenger.of(ctx)
        .showSnackBar(SnackBar(content: Text(textLoadState.message)));
  }

  void _presentTextDifficultyPickingDialog(
      BuildContext context, TextBloc _textBloc) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                text: 'Easy',
                onTap: () {
                  _textBloc.add(LoadText(textDifficulty: TextDifficulty.Easy));
                  Navigator.of(context).pop();
                },
              ),
              AppButton(
                text: 'Medium',
                onTap: () {
                  _textBloc
                      .add(LoadText(textDifficulty: TextDifficulty.Medium));
                  Navigator.of(context).pop();
                },
              ),
              AppButton(
                text: 'Hard',
                onTap: () {
                  _textBloc.add(LoadText(textDifficulty: TextDifficulty.Hard));
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
