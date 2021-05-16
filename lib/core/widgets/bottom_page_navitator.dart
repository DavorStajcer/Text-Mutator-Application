import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BottomPageNavigator extends StatelessWidget {
  final Size deviceSize;
  final Function() proceedeOnTapFunction;
  final Function() backOnTapFunction;
  final Widget proceedWidget;
  const BottomPageNavigator({
    Key? key,
    required this.deviceSize,
    required this.proceedeOnTapFunction,
    required this.proceedWidget,
    required this.backOnTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 8, 50, 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: backOnTapFunction,
              child: AutoSizeText(
                '<- Back',
                style: _theme.textTheme.headline3,
              ),
            ),
            GestureDetector(
              onTap: proceedeOnTapFunction,
              child: proceedWidget,
            ),
          ],
        ),
      ),
    );
  }
}
