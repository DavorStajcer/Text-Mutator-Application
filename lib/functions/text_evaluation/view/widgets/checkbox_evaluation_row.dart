import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:text_mutator/functions/text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';

class CheckBoxEvaluationRow extends StatelessWidget {
  const CheckBoxEvaluationRow({
    Key? key,
    required ThemeData theme,
    required this.value,
    required this.valueName,
    this.onChanged,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;
  final bool value;
  final String valueName;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        AutoSizeText(
          valueName,
          textAlign: TextAlign.left,
          style: _theme.textTheme.bodyText1,
        ),
        Icon(Icons.mark_chat_read_outlined),
      ],
    );
  }
}
