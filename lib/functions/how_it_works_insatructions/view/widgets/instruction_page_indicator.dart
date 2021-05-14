import 'package:flutter/material.dart';

class InstructionPageIndicator extends StatelessWidget {
  final int currentlyPreviewdPageIndex;
  const InstructionPageIndicator({
    Key? key,
    required this.currentlyPreviewdPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleIndicator(
          currentlyPreviewdPageIndex: currentlyPreviewdPageIndex,
          theme: _theme,
          pagePresentingIndex: 0,
        ),
        CircleIndicator(
          currentlyPreviewdPageIndex: currentlyPreviewdPageIndex,
          theme: _theme,
          pagePresentingIndex: 1,
        ),
        CircleIndicator(
          currentlyPreviewdPageIndex: currentlyPreviewdPageIndex,
          theme: _theme,
          pagePresentingIndex: 2,
        ),
        CircleIndicator(
          currentlyPreviewdPageIndex: currentlyPreviewdPageIndex,
          theme: _theme,
          pagePresentingIndex: 3,
        )
      ],
    );
  }
}

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({
    Key? key,
    required this.currentlyPreviewdPageIndex,
    required ThemeData theme,
    required this.pagePresentingIndex,
  })   : _theme = theme,
        super(key: key);

  final int currentlyPreviewdPageIndex;
  final int pagePresentingIndex;

  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentlyPreviewdPageIndex != pagePresentingIndex
            ? _theme.textTheme.bodyText1!.color
            : _theme.accentColor,
      ),
    );
  }
}
