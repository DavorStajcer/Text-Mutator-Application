import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
          maxLines: 1,
          style: _theme.textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
