import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextDataDisplayRow extends StatelessWidget {
  const TextDataDisplayRow({
    Key? key,
    required ThemeData theme,
    required this.text,
    required this.data,
    this.autoSizeGroup,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;
  final String text;
  final String data;
  final AutoSizeGroup? autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        flex: 4,
        child: AutoSizeText(
          text,
          maxLines: 1,
          group: autoSizeGroup,
          style: _theme.textTheme.bodyText1!
              .copyWith(fontWeight: FontWeight.w700)
              .copyWith(fontSize: 20),
        ),
      ),
      Flexible(
        flex: 1,
        child: AutoSizeText(
          data,
          maxLines: 1,
          group: autoSizeGroup,
          style: _theme.textTheme.bodyText1!
              .copyWith(fontWeight: FontWeight.w700)
              .copyWith(fontSize: 20),
        ),
      ),
    ]);
  }
}
